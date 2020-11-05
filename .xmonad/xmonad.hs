-- ~/.xmonad/xmonad.hs
--
--  daniel testa 20-10-2020

----   IMPORTS    ----

--Sistema base
import XMonad
import Data.Monoid
import System.Exit
import System.IO

-- Aciones
import XMonad.Actions.WithAll(sinkAll, killAll) --Cierra todas las ventanas en el WS 

-- Hooks
import XMonad.Hooks.DynamicLog     -- enlaza xmobar y otras barras de estado
import XMonad.Hooks.ManageDocks    -- evita que las ventanas tapen a la barra es estadi
import XMonad.Hooks.ManageHelpers  -- doCenterFloat, ventana flotante en el centro de la pantalla

-- Utilidades
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce

-- Layouts
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed

-- Modificadores de Layout
import XMonad.Layout.Spacing
import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances(StdTransformers(NBFULL, MIRROR, NOBORDERS))
import qualified XMonad.Layout.MultiToggle as MT


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
myNormalBorderColor = "#839496"


myFocusedBorderColor :: String
myFocusedBorderColor = "#268bd2"


----     ESCRITORIOS    ----

-- \xf1de  , \xfa7b 嗢,\xe777  
-- \xf269  , \xfa87 慎, \xf0ac  , \xf484  , 爵
-- \xf120  , \xf489  , \xf68c  , \xe695  
-- "\xfc58 ﱘ , \xf886 , \xf883  ,\xf884  , \xf885  
myWorkspaces = [ " \xf120  ", " \xf269  ", " \xf1de  ", " \xfc58 \xf886 " ] ++ map show [5..9]


----     ATAJOS DE TECLADO    ----

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    [
-- programas
      ((modm,  xK_Return), spawn $ XMonad.terminal conf)
    , ((modm,  xK_p     ), spawn "dmenu_run")
    , ((modm,  xK_f     ), spawn "firefox")
    , ((controlMask .|. shiftMask, xK_Escape  ), spawn "alacritty -e htop")
    , ((modm .|. shiftMask, xK_m), spawn "alacritty --class=Cmus,Cmus -e cmus")

-- xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))                    -- Salir de xmonad
    , ((modm,  xK_q     ), spawn "xmonad --recompile; xmonad --restart") -- Reiniciar

-- layous
    , ((modm,  xK_space ), sendMessage NextLayout)                          -- Rotar entre layouts
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- Restablecer predeterminado
    , ((modm,  xK_n     ), refresh)                                         -- Volver al tamaño normal
    , ((modm,  xK_F11   ), sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- sin bordes/full
    , ((modm,  xK_b     ), sendMessage ToggleStruts)                        -- Interruptor barra de estado visible
                                                                           
    , ((modm .|. shiftMask, xK_n     ), sendMessage $ MT.Toggle NOBORDERS)  -- Interruptor para bordes de ventanas

-- ventanas
    , ((modm .|. shiftMask, xK_c     ), kill)         -- Cierra ventana actual
    , ((modm .|. shiftMask, xK_a     ), killAll)      -- Cierra todas la ventanas del escritorio actual

-- moverse entre ventanas
    , ((modm,  xK_Tab   ), windows W.focusDown)  -- Foco en siguiente
    , ((modm,  xK_j     ), windows W.focusDown)  -- Foco en siguiente
    , ((modm,  xK_Down  ), windows W.focusDown)  -- Foco en siguiente
    , ((modm,  xK_k     ), windows W.focusUp  )  -- Foco en anterior
    , ((modm,  xK_Up    ), windows W.focusUp  )  -- Foco en anterior
    , ((modm,  xK_m     ), windows W.focusMaster  ) -- Foco en Master
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster) -- Intercambia actual <-> Master
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  ) -- Intercambia actual <-> Siguiente
    , ((modm .|. shiftMask, xK_Down  ), windows W.swapDown  ) -- Intercambia actual <-> Siguiente
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    ) -- Intercambia actual <-> Anterior
    , ((modm .|. shiftMask, xK_Up    ), windows W.swapUp    ) -- Intercambia actual <-> Anterior
    , ((modm,  xK_h     ), sendMessage Shrink)   -- Achica Master
    , ((modm,  xK_l     ), sendMessage Expand)   -- Agranda Master
    , ((modm,  xK_t     ), withFocused $ windows . W.sink) -- Vuelve la ventana actual a mosaico
    , ((modm,  xK_comma ), sendMessage (IncMasterN 1))     -- Incrementa el n de ventanas en Master
    , ((modm,  xK_period), sendMessage (IncMasterN (-1)))  -- Disminuye el n de ventanas en Master

-- modificadores estéticos 
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


----    DISEÑOS    ----

--
-- \xfa6a 頻, \xfa6b 恵, \xfa6c 𤋮, \xfa6d 舘, \xfa6e 﩮, \xda6f 﩯, \xfa71 况, \xfa72 全
-- \xfa73 侀, \xfa74 充, \xfa75 冀, \xfb3f ﬿ , \xe75a  , \xfa69 響,﵁  \xfc61 ﱡ , \xfc62 ﱢ
-- \xf53c  , \xf53e  , \xf984 濾, \xf985 礪 \xf366  , \xf367 
--

myLayout = vertical ||| horizontal ||| completo
  where
     -- predeterminado + espacio (4)
    vertical   = renamed [Replace "\xfb3f "]
                 $ avoidStruts
                 $ spacing 4
                 $ Tall nmaster delta ratio
    nmaster    = 1               -- Numero predeterminado de ventanas en el area Master
    ratio      = 1/2             -- Proporcion predeterminada de pantalla ocupada por Master
    delta      = 3/100           -- % de pantalla a incrementar al cambiar de tamano


     -- igual a Tall pero con horizontal
    horizontal = renamed [Replace "\xfa69 "] 
                 $ avoidStruts
            --     $ spacing 4
                 $ Mirror vertical


     -- pantalla completa con bordes
    completo   = renamed [Replace "\xfc61 "]
                 $ noBorders 
                 $ Full 



----    REGLAS PARA VENTANAS ESPECIFICAS    ----

myManageHook = composeAll
    [ className =? "Gimp"    --> doFloat
    , className =? "mpv"    --> doF (W.shift "5")
    , className =? "firefox"    --> doShift " \xf269  "
    ,(className =? "Firefox" <&&> resource =? "Dialog")    --> doFloat
    , className =? "Cmus"    --> doF (W.shift " \xfc58 \xf886 ")
    , className =? "Nitrogen"    --> doCenterFloat
    , className =? "Nm-connection-editor"    --> doCenterFloat
    ]


----    PROGRAMAS DE INICIO    ----

myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom &"
    spawnOnce "nm-applet &"
    spawnOnce "volumeicon &"
    spawnOnce "trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --expand true --monitor 0 --transparent true --alpha 0 --tint 0x002b36  --height 18 &"


----------------------------
----    INICIO XMONAD   ----
----------------------------

main = do
    xmproc <- spawnPipe "xmobar -x 0 ~/.config/xmobar/xmobarrc"

    xmonad $ docks def
        { manageHook = myManageHook <+> manageHook def 
        , layoutHook = myLayout
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppCurrent = xmobarColor "#fdf6e3" "" . wrap "\xe0d2" "\xe0d4"
                        , ppHidden = xmobarColor "#839496" "" -- . wrap "\xe0b7" "\xe0b5"
                        , ppLayout = xmobarColor "#6c71c4" "" 
                        , ppTitle = xmobarColor "#268bd2" "" . shorten 100
                        , ppSep = "<fc=#fdf6e3>  \xe0b1   </fc>"
                        , ppWsSep = "<fc=#fdf6e3> \xf142 </fc>"


---- \xe0b7  , \xe0b5 , \xe0d2  , \xe0d4  ,  \xfc5e ﱞ , \xfc16 ﰖ,  \xf142 


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
