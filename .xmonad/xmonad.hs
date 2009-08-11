import XMonad
import qualified XMonad.StackSet as W
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
import XMonad.Prompt.RunOrRaise
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spiral
import XMonad.Layout.Accordion
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import Control.Monad
import System.IO
import Data.List
import Data.Ratio ((%))
import qualified Data.Map as M

myManageHook = composeAll 
    [  className =? "Xmessage"  --> doFloat 
    ,  className =? "Gran Paradiso" --> doShift "WEB" 
    , (className =? "Gran Paradiso" <&&> resource =? "Dialog") --> doFloat 
    ,  className =? "Pidgin"  --> doShift "IM"      
    ,  title     =? "htop"     --> doShift "MNTR"
    ,  title     =? "irssi"    --> doShift "IRSSI"
    ,  title     =? "ncmpcpp"  --> doShift "MUSIC"
    ,  title     =? "curiousfocus"  --> doShift "TERM"      
    ] 


mylayoutHook = smartBorders $ tiled ||| Mirror tiled ||| Full
    where
	tiled = Tall nmaster delta ratio
	nmaster = 1
	delta = 3 / 100
	ratio = 3 / 5

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ withUrgencyHook NoUrgencyHook defaultConfig
	{ manageHook        = manageHook defaultConfig <+> myManageHook 
	, layoutHook        = avoidStruts $ mylayoutHook
	, terminal          = "urxvt"
	, modMask           = mod4Mask
	, focusFollowsMouse = False
	, borderWidth       = 4
	, keys              = \c -> mykeys c `M.union` keys defaultConfig c 
	, normalBorderColor = "#000000"
	, focusedBorderColor = "#006699"
	, workspaces        = ["WEB","IRSSI","TERM","IM","MUSIC","MNTR","#"]   
	, logHook           = do
			         dynamicLogWithPP  xmobarPP
			          { ppOutput          = hPutStrLn xmproc
			          , ppCurrent         = xmobarColor "#00CCFF" ""
			          , ppHidden          = xmobarColor "#0066CC" ""
			          , ppHiddenNoWindows = xmobarColor "#333333" ""
			          , ppTitle           = xmobarColor "#3399FF" "" . shorten 50
			          , ppUrgent          = xmobarColor "yellow" "red" 
			          } 

	}	
	where
            mykeys (XConfig {modMask = modm}) = M.fromList $
		[   ((modm, xK_f), spawn "firefox")  	
		  , ((modm, xK_s), spawn "urxvt -e vim ~/.xmonad/xmonad.hs")
		  , ((modm .|. shiftMask, xK_apostrophe), spawn "ncmpcpp toggle")
		  , ((modm .|. shiftMask, xK_comma), spawn "ncmpcpp prev")	
	          , ((modm .|. shiftMask, xK_period), spawn "ncmpcpp next")
		  , ((modm .|. shiftMask, xK_p), spawn "ncmpcpp stop")
		  , ((modm .|. controlMask, xK_p), runOrRaisePrompt defaultXPConfig)]
        	++	
		  [ ((modm, key), screenWorkspace sc >>= flip whenJust (windows . f)) 
                      | (key, sc) <- zip [xK_w, xK_v, xK_z] [0..]
                      , (f, m) <- [(W.view, 0)]] 
        	
