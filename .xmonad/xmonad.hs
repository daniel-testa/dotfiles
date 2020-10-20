-- ~/.xmonad/xmonad.hs
--
--  daniel testa 20-10-2020

----   IMPORTS    ----

import XMonad
import Data.Monoid
import System.Exit
import System.IO
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce

import qualified XMonad.StackSet as W
import qualified Data.Map as M


----   VARIABLES    ----

myTerminal :: String
myTerminal = "alacritty"

myModMask :: KeyMask
myModMask = mod4Mask

myBorderWidth :: Dimension
myBorderWidth = 2

myNormalBorderColor :: String
myNormalBorderColor = "#b58900"


myFocusedBorderColor :: String
myFocusedBorderColor = "#cb4b16"


----     ESCRITORIOS    ----
   
myWorkspaces = [ "cli", "web", "sys" ] ++ map show [4..9]


----     ATAJOS DE TECLADO    ----

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)
    , ((modm,               xK_p     ), spawn "dmenu_run")
    , ((modm .|. shiftMask, xK_c     ), kill)                   -- Cierra ventana actual
    , ((modm,               xK_space ), sendMessage NextLayout) -- Rotar entre layouts
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- Resetear a predeterminado
    , ((modm,               xK_n     ), refresh)              -- Volver al tamano normal
    , ((modm,               xK_Tab   ), windows W.focusDown)  -- Foco en siguiente
    , ((modm,               xK_j     ), windows W.focusDown)  -- Foco en siguiente
    , ((modm,               xK_k     ), windows W.focusUp  )  -- Foco en anterior
    , ((modm,               xK_m     ), windows W.focusMaster  ) -- Focon en Master
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster) -- Intercambia Foco <-> Master
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  ) -- Intercambia Foco <-> Siguiente
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    ) -- Intercambia Foco <-> Anterior
    , ((modm,               xK_h     ), sendMessage Shrink)   -- Achica Master
    , ((modm,               xK_l     ), sendMessage Expand)   -- Agranda Master
    , ((modm,               xK_t     ), withFocused $ windows . W.sink) -- Vuelve la ventana a mosaico
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))     -- Incrementa el n de ventanas en Master
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))  -- Disminuye el n de ventanas en Master
--    , ((modm              , xK_b     ), sendMessage ToggleStruts)     -- Elimina o agregar espacio para barras de estado
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))                    -- Salir de xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart") -- Reiniciar
    ]
    ++
    -- mod-[1..9], Cambiar al escritorio N
    -- mod-shift-[1..9], Mover la ventana al escritorio N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]


----     ATAJOS DEL MOUSE    ----

myMouse (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]


----    DISENOS    ----

myLayout = avoidStruts (tiled ||| Mirror tiled ||| Full)
  where
     tiled   = Tall nmaster delta ratio -- Algoritmo predeterminado, divide la pantalla en dos paneles
     nmaster = 1  -- Numero predeterminado de ventanas en el area Master
     ratio   = 1/2 -- Proporcion predeterminada de pantalla ocupada por Master
     delta   = 3/100 -- % de pantalla a incrementar al cambiar de tamano


----    REGLAS PARA VENTANAS ESPECIFICAS    ----

myManageHook = composeAll
    [ className =? "Gimp"  --> doFloat
    , className =? "mpv"   --> doFloat
    ]


----    PROGRAMAS DE INICIO    ----

myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom &"


----------------------------
----    INICIO XMONAD   ----
----------------------------

main = do
    xmproc <- spawnPipe "xmobar -x 0 ~/.config/xmobar/xmobarrc"
    xmonad $ docks defaultConfig
        { manageHook = myManageHook <+> manageHook defaultConfig 
        , layoutHook = myLayout
--        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#b58900" "" . shorten 50
                        }
        , startupHook = myStartupHook
        , terminal = myTerminal
        , modMask = mod4Mask
        , borderWidth = myBorderWidth
        , normalBorderColor = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , workspaces = myWorkspaces
        , keys = myKeys
        , mouseBindings = myMouse
        } 
