-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┒
-- ┃ ___   _____ __ __ __ _____ __     ______ _____ _____ ______ _____ ┃
-- ┃|    \|  _  |   \ |__|   __|  |   |      |   __|   __|      |  _  |┃
-- ┃| |   |     |     |  |   __|  --; '_    _'   __|__   '_    _'     |┃
-- ┃|____/|__|__|__\__|__|_____|____|   |__| |_____|_____| |__| |__|__|┃
-- ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
-- ┃daniel.testa.t@gmail.com 20.10.2020                                ┃
-- ┃   ~/.xmonad/xmonad.hs                                             ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

----   IMPORTS    ----

--Sistema base
import XMonad
import Data.Monoid
import System.Exit
import System.IO

-- Aciones
import XMonad.Actions.WithAll(sinkAll, killAll) --Cierra todas las ventanas en el WS 
import XMonad.Actions.WindowGo (runOrRaise)     --Lanza programa o hace foco si ya está corriendo

-- Hooks
import XMonad.Hooks.DynamicLog     -- enlaza xmobar y otras barras de estado
import XMonad.Hooks.ManageDocks    -- evita que las ventanas tapen a la barra es estado
import XMonad.Hooks.ManageHelpers  -- doCenterFloat, ventana flotante en el centro de la pantalla

-- Utilidades
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce

-- Layouts
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spiral
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ThreeColumns

-- Modificadores de Layout
import XMonad.Layout.Spacing
import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances(StdTransformers(NBFULL, MIRROR, NOBORDERS))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT


import qualified XMonad.StackSet as W
import Control.Monad (liftM2)
import qualified Data.Map as M


----   VARIABLES    ----

myTerminal :: String
myTerminal = "alacritty"

myModMask :: KeyMask
myModMask = mod4Mask

myBorderWidth :: Dimension
myBorderWidth = 1

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


------     ATAJOS DE TECLADO    ----
--
--myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
--
--    [
---- programas
--      ((modm,  xK_Return), spawn $ XMonad.terminal conf)
--    , ((modm,  xK_p     ), spawn "dmenu_run")
--    , ((modm,  xK_f     ), spawn "firefox")
--    , ((controlMask .|. shiftMask, xK_Escape  ), spawn "alacritty -e htop")
--    , ((modm .|. shiftMask, xK_m), spawn "alacritty --class=Cmus,Cmus -e cmus")
--
---- xmonad
--    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))                    -- Salir de xmonad
--    , ((modm,  xK_q     ), spawn "xmonad --recompile; xmonad --restart") -- Reiniciar
--
---- layous
--    , ((modm,  xK_space ), sendMessage NextLayout)                          -- Rotar entre layouts
--    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- Restablecer predeterminado
--    , ((modm,  xK_n     ), refresh)                                         -- Volver al tamaño normal
--    , ((modm,  xK_F11   ), sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- sin bordes/full
--    , ((modm,  xK_b     ), sendMessage ToggleStruts)                        -- Interruptor barra de estado visible
--                                                                           
--    , ((modm .|. shiftMask, xK_n     ), sendMessage $ MT.Toggle NOBORDERS)  -- Interruptor para bordes de ventanas
--
---- ventanas
--    , ((modm .|. shiftMask, xK_c     ), kill)         -- Cierra ventana actual
--    , ((modm .|. shiftMask, xK_a     ), killAll)      -- Cierra todas la ventanas del escritorio actual
--
---- moverse entre ventanas
--    , ((modm,  xK_Tab   ), windows W.focusDown)  -- Foco en siguiente
--    , ((modm,  xK_j     ), windows W.focusDown)  -- Foco en siguiente
--    , ((modm,  xK_Down  ), windows W.focusDown)  -- Foco en siguiente
--    , ((modm,  xK_k     ), windows W.focusUp  )  -- Foco en anterior
--    , ((modm,  xK_Up    ), windows W.focusUp  )  -- Foco en anterior
--    , ((modm,  xK_m     ), windows W.focusMaster  ) -- Foco en Master
--    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster) -- Intercambia actual <-> Master
--    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  ) -- Intercambia actual <-> Siguiente
--    , ((modm .|. shiftMask, xK_Down  ), windows W.swapDown  ) -- Intercambia actual <-> Siguiente
--    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    ) -- Intercambia actual <-> Anterior
--    , ((modm .|. shiftMask, xK_Up    ), windows W.swapUp    ) -- Intercambia actual <-> Anterior
--    , ((modm,  xK_h     ), sendMessage Shrink)   -- Achica Master
--    , ((modm,  xK_l     ), sendMessage Expand)   -- Agranda Master
--    , ((modm,  xK_t     ), withFocused $ windows . W.sink) -- Vuelve la ventana actual a mosaico
--    , ((modm,  xK_comma ), sendMessage (IncMasterN 1))     -- Incrementa el n de ventanas en Master
--    , ((modm,  xK_period), sendMessage (IncMasterN (-1)))  -- Disminuye el n de ventanas en Master
--
--    ]
--    ++
--    -- mod-[1..9], Cambiar al escritorio N
--    -- mod-shift-[1..9], Mover la ventana al escritorio N
--    [((m .|. modm, k), windows $ f i)
--        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
--        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
--

myKeys :: [(String, X ())]
myKeys =
    -- programas 
        [ ("M-<Return>", spawn myTerminal)
        , ("M-d", spawn "dmenu_daniel")
        , ("M-r", spawn "rofi -show-icons -show drun")
        , ("M-f", spawn "firefox")
        , ("C-S-<Escape>", spawn "alacritty -e htop")
        , ("M-S-m", spawn "alacritty --class=Cmus,Cmus -e cmus")
    
    -- xmonad
        , ("M-S-q", io (exitWith ExitSuccess))                  -- Salir de xmonad
        , ("C-M1-<Delete>", spawn "loginctl terminate-user 1000")                  -- Salir de xmonad
        , ("M-q", spawn "xmonad --recompile; xmonad --restart") -- Reiniciar
    
    -- layouts
        , ("M-<Space>", sendMessage NextLayout)                          -- Rotar entre layouts
--        , ("M-S-<Space>", setLayout $ XMonad.layoutHook conf) Restablecer predeterminado (xxx no funciona)
        , ("M-n", refresh)                                     -- Volver al tamaño normal
        , ("M-<F11>", sendMessage (MT.Toggle NBFULL))          -- sin bordes/full
--        , ("M-<F10>", sendMessage (T.Toggle "flotante")) -- layout flotante (xx no funciona) 
        , ("M-b", sendMessage ToggleStruts)                    -- Interruptor barra de estado visible
                                                                               
        , ("M-S-n", sendMessage $ MT.Toggle NOBORDERS)  -- Interruptor para bordes de ventanas
    
    -- ventanas
        , ("M-S-c", kill)         -- Cierra ventana actual
        , ("M-S-a", killAll)      -- Cierra todas la ventanas del escritorio actual
    
    -- moverse entre ventanas
        , ("M-<Tab>", windows W.focusDown)  -- Foco en siguiente
        , ("M-j", windows W.focusDown)  -- Foco en siguiente
        , ("M-<Down>", windows W.focusDown)  -- Foco en siguiente
        , ("M-k", windows W.focusUp)  -- Foco en anterior
        , ("M-<Up>", windows W.focusUp)  -- Foco en anterior
        , ("M-m", windows W.focusMaster) -- Foco en Master
        , ("M-S-<Return>", windows W.swapMaster) -- Intercambia actual <-> Master
        , ("M-S-j", windows W.swapDown) -- Intercambia actual <-> Siguiente
        , ("M-S-<Down>", windows W.swapDown) -- Intercambia actual <-> Siguiente
        , ("M-S-k", windows W.swapUp) -- Intercambia actual <-> Anterior
        , ("M-S-<Up>", windows W.swapUp) -- Intercambia actual <-> Anterior
        , ("M-h", sendMessage Shrink)   -- Achica Master
        , ("M-l", sendMessage Expand)   -- Agranda Master
        , ("M-t", withFocused $ windows . W.sink) -- Vuelve la ventana actual a mosaico
        , ("M-,", sendMessage (IncMasterN 1))     -- Incrementa el n de ventanas en Master
        , ("M-.", sendMessage (IncMasterN (-1)))  -- Disminuye el n de ventanas en Master

     -- teclas especiales
        , ("<XF86Calculator>", runOrRaise "kcalc" (resource =? "kcalc"))
        , ("<XF86Explorer>", runOrRaise "dolphin" (resource =? "dolphin"))
        , ("<XF86HomePage>", spawn "firefox")
    -- Teclas multimedia
        , ("<XF86AudioPlay>", spawn "cmus-remote --pause")
        , ("<XF86AudioStop>", spawn "cmus-remote --stop")
        , ("<XF86AudioPrev>", spawn "cmus-remote --prev")
        , ("<XF86AudioNext>", spawn "cmus-remote --next")
        , ("<XF86AudioMute>", spawn "pacmd set-sink-mute alsa_output.pci-0000_07_00.6.analog-stereo false")
        , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
        , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
        , ("<Print>", spawn "scrotd 0")
        ]

----     ATAJOS DEL MOUSE    ----

myMouse (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]


----    DISEÑOS    ----

     -- predeterminado + espacio (4)
vertical   = renamed [Replace "\xfb3f "]
             $ avoidStruts
             $ spacing 4
             $ Tall nmaster delta ratio
nmaster    = 1               -- Numero predeterminado de ventanas en el area Master
ratio      = 1/2             -- Proporcion predeterminada de pantalla ocupada por Master
delta      = 3/100           -- % de pantalla a incrementar al cambiar de tamano

tiled      = Tall nmaster delta ratio  -- definido solo para usar en mirror tiled
horizontal = renamed [Replace "\xfa69 "] 
             $ avoidStruts
             $ spacing 4
             $ Mirror tiled 


 -- pantalla completa con bordes
completo   = renamed [Replace "\xf53c "]
             $ noBorders 
             $ Full

espiral    = renamed [Replace "\xfa73 "]
             $ avoidStruts
             $ spiral (6/7)

tresCol    = renamed [Replace "\xfa75 "]
             $ avoidStruts
             $ ThreeCol 1 (3/100) (1/2)

flotante    = renamed [Replace "\xfa6b "]
             $ avoidStruts
             $ simplestFloat

-- \xfa6a 頻, \xfa6b 恵, \xfa6c 𤋮, \xfa6d 舘, \xfa6e 﩮, \xda6f 﩯, \xfa71 况, \xfa72 全
-- \xfa73 侀, \xfa74 充, \xfa75 冀, \xfb3f ﬿ , \xfa69 響,﵁  \xfc61 ﱡ , \xfc62 ﱢ
-- \xf53c  , \xf53e  , \xf984 濾, \xf985 礪 \xf366  , \xf367 

myLayout = T.toggleLayouts flotante $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
  where
    myDefaultLayout = vertical ||| horizontal ||| completo ||| espiral ||| tresCol ||| flotante


----    REGLAS PARA VENTANAS ESPECIFICAS    ----

myManageHook = composeAll
    [ className =? "Gimp"    --> doFloat
    , className =? "mpv"    -->  doShift "5"
    , className =? "firefox"    --> doShift " \xf269  "
    ,(className =? "firefox" <&&> resource =? "Dialog")    --> doFloat
    ,(className =? "firefox" <&&> resource =? "Toolkit")    --> doFloat -- firefox PIP flotante 
    , className =? "TeamViewer"    --> shiftAndFollow "5" <+> doFloat
    , title =? "Oracle VM VirtualBox Administrador"    --> shiftAndFollow "6" <+> doFloat
    , className =? "dolphin"    --> shiftAndFollow "6" <+> doFloat
    , className =? "Nitrogen"    --> doCenterFloat
    , className =? "Nm-connection-editor"    --> doCenterFloat
--    , className =? "Cmus"    --> doF (W.shift " \xfc58 \xf886 ")
    ]
  where shiftAndFollow = doF . liftM2 (.) W.greedyView W.shift   -- func envía ventana a xWs y hace foco en xWs

----    PROGRAMAS DE INICIO    ----

myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom &"
--    spawnOnce "nm-applet &"
--    spawnOnce "volumeicon &"
--    spawnOnce "trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --expand true --monitor 0 --transparent true --alpha 0 --tint 0x002b36  --height 18 &"


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
                        , ppCurrent = xmobarColor "#fdf6e3" "" -- . wrap "\xe0d2" "\xe0d4"
                        , ppVisible = xmobarColor "#6c71c4" ""
                        , ppHidden = xmobarColor "#839496" "" -- . wrap "\xe0b7" "\xe0b5"
                        , ppHiddenNoWindows = xmobarColor "#6c71c4" ""
                        , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"
                        , ppLayout = xmobarColor "#6c71c4" "" 
                        , ppTitle = xmobarColor "#268bd2" "" . shorten 100
                        , ppSep = "<fc=#fdf6e3>  \xe0b1   </fc>"
                        , ppWsSep = "<fc=#fdf6e3> \x2503 </fc>"
                        }
        , startupHook = myStartupHook
        , terminal = myTerminal
        , modMask = mod4Mask
        , borderWidth = myBorderWidth
        , normalBorderColor = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , workspaces = myWorkspaces
--        , keys = myKeys
        , mouseBindings = myMouse
        } `additionalKeysP` myKeys
