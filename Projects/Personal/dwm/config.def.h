/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "JetBrainsMono Nerd Font:size=11" };
static const char dmenufont[]       = "JetBrainsMono Nerd Font:size=16";
static char normbgcolor[]           = "#222222";
static char normbordercolor[]       = "#444444";
static char normfgcolor[]           = "#bbbbbb";
static char selfgcolor[]            = "#eeeeee";
static char selbordercolor[]        = "#005577";
static char selbgcolor[]            = "#005577";
static char *colors[][3] = {
       /*               fg           bg           border   */
       [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
       [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};

typedef struct {
	const char *name;
	const void *cmd;
} Sp;
const char *spcmd1[] = {"st", "-n", "spterm", NULL };
const char *spcmd2[] = {"st", "-n", "spfloatterm", NULL };
const char *spcmd3[] = {"st", "-n", "spfm", "-e", "ranger", NULL };
const char *spcmd4[] = {"st", "-n", "spvol", "-e", "pulsemixer", NULL };
const char *spcmd5[] = {"st", "-n", "spbt", "-e", "bluetui", NULL };
const char *spcmd6[] = {"st", "-n", "sptop", "-e", "htop", NULL };
static Sp scratchpads[] = {
	/* name           cmd  */
	{"spterm",        spcmd1},
	{"spfloatterm",   spcmd2},
	{"spfm",          spcmd3},
	{"spvol",         spcmd4},
	{"spbt",          spcmd5},
	{"sptop",         spcmd6},
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class          instance      title       tags mask     isfloating   monitor    float x,y,w,h         floatborderpx*/
	{ "Code",         NULL,         NULL,       1 << 1,       0,           -1,        50,50,500,500,        5 },
	{ "Slack",        NULL,         NULL,       1 << 3,       0,           -1,        50,50,500,500,        5 },
	{ "Galculator",   NULL,         NULL,       0,            1,           -1,        50,50,300,380,        5 },
	{ "1Password",    NULL,         NULL,       0,            1,           -1,        50,50,900,700,        5 },
	{ NULL,           "spterm",     NULL,       SPTAG(0),     0,           -1,        50,50,500,500,        2 },
	{ NULL,           "spfloatterm",NULL,       SPTAG(1),     1,           -1,        50,10,1900,900,       3 },
	{ NULL,           "spfm",       NULL,       SPTAG(2),     1,           -1,        50,80,1400,500,       4 },
	{ NULL,           "spvol",      NULL,       SPTAG(3),     1,           -1,        50,90,1000,300,       4 },
	{ NULL,           "spbt",       NULL,       SPTAG(4),     1,           -1,        50,0,800,1000,        4 },
	{ NULL,           "sptop",      NULL,       SPTAG(5),     1,           -1,        50,50,1600,900,       5 },
};

/* layout(s) */
static const float mfact     = 0.60; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALT Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { 
  "dmenu_run", 
  "-l", "7",
  "-c",
  NULL };

static const char *termcmd[]  = { "st", NULL };
static const char *clipboardmenu[]  = { "/home/frank/.local/bin/clipboard-menu", NULL };
static const char *keyboardmenu[]  = { "/home/frank/.local/bin/keyboard-swithcer-menu", NULL };
static const char *appsmenu[]  = { "/home/frank/.local/bin/favorites-apps-menu", NULL };
static const char *screenshotsmenu[]  = { "/home/frank/.local/bin/screenshots-menu", NULL };
static const char *powermenu[]  = { "/home/frank/.local/bin/power-menu", NULL };
static const char *upvol[] = { "/sbin/pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%", NULL };
static const char *downvol[] = { "/sbin/pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%", NULL };
static const char *mutevol[] = { "/sbin/pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle", NULL };
static const char *playernext[] = { "/sbin/playerctl", "next", NULL };
static const char *playerprev[] = { "/sbin/playerctl", "previous", NULL };
static const char *playertoggle[] = { "/sbin/playerctl", "play-pause", NULL };
static const char *light_up[]   = { "/sbin/brightnessctl", "s", "+10%", NULL };
static const char *light_down[] = { "/sbin/brightnessctl", "s", "10%-", NULL };

#include <X11/XF86keysym.h>
static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ ALT|ControlMask,              XK_h,      spawn,          {.v = clipboardmenu } },
	{ ALT|ControlMask,              XK_space,  spawn,          {.v = keyboardmenu } },
	{ ALT|ControlMask,              XK_p,      spawn,          {.v = appsmenu } },
	{ ALT|ControlMask,              XK_x,      spawn,          {.v = powermenu } },
	{ 0,                            XK_Print,  spawn,          {.v = screenshotsmenu } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_f,      fullscreen,     {0} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_F5,     xrdb,           {.v = NULL } },
	{ MODKEY,                       XK_grave,  togglescratch,  {.ui = 0 } },
	{ MODKEY,                       XK_w,      togglescratch,  {.ui = 1 } },
	{ MODKEY,                       XK_n,      togglescratch,  {.ui = 2 } },
	{ MODKEY,                       XK_v,      togglescratch,  {.ui = 3 } },
	{ MODKEY,                       XK_e,      togglescratch,  {.ui = 4 } },
	{ MODKEY,                       XK_Escape, togglescratch,  {.ui = 5 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
  { 0,                            XF86XK_AudioLowerVolume,    spawn,  {.v = downvol } },
	{ 0,                            XF86XK_AudioMute,           spawn,  {.v = mutevol } },
	{ 0,                            XF86XK_AudioRaiseVolume,    spawn,  {.v = upvol   } },
  { 0,                            XF86XK_MonBrightnessUp,     spawn,  {.v = light_up} },
	{ 0,                            XF86XK_MonBrightnessDown,   spawn,  {.v = light_down} },
	{ 0,                            XF86XK_AudioNext,           spawn,  {.v = playernext} },
	{ 0,                            XF86XK_AudioPrev,           spawn,  {.v = playerprev} },
	{ 0,                            XF86XK_AudioPlay,           spawn,  {.v = playertoggle} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

