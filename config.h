
/* See LICENSE file for copyright and license details. */
#ifndef CONFIG_H
#define CONFIG_H

#include <xkbcommon/xkbcommon-keysyms.h>

/* appearance */
static const unsigned int borderpx       = 1; /* border pixel of windows */
// static const int showbar = 1;           /* 0 means no bar */
// static const int topbar = 1;            /* 0 means bottom bar */
// static const int sloppyfocus = 1;       /* focus follows mouse */
static const char *fonts[]               = { "monospace:size=10" };
static const uint32_t rootcolor          = 0xff222222;
static const uint32_t bordercolor        = 0xff444444;
static const uint32_t focuscolor         = 0xff005577;
static const uint32_t urgentcolor        = 0xff0000ff;

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

/* layout(s) */
static const uint32_t master_size        = 60; /* % of screen */
static const int nmaster                 = 1;                  /* number of clients in master area */
static const int resizehints             = 1;              /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen          = 1;           /* 1 will force focus on the fullscreen window */
static const uint32_t motion_refreshrate = 90; /* refresh rate (per second) for client move/resize */

// static const Layout layouts[] = {
//     /* symbol     arrange function */
//     { "[]=",      tile}, /* first entry is default */
//     { "><>",      NULL}, /* no layout function means floating behavior */
//     { "[M]",      monocle},
// };

/* key definitions */
#define MODKEY MOD4
#define TAGKEYS(KEY, TAG)   \
        { MODKEY,                       KEY,     view,           {.ui = 1 << TAG} },    \
        { MODKEY|ControlMask,           KEY,     toggleview,     {.ui = 1 << TAG} },    \
        { MODKEY|ShiftMask,             KEY,     tag,            {.ui = 1 << TAG} },    \
        { MODKEY|ControlMask|ShiftMask, KEY,     toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *menucmd[] = { "neumenu_run", NULL };
static const char *termcmd[]  = { "st-wl", NULL };

static struct bind binds[] = {
	/* keyboard */
	{ SWC_BINDING_KEY,    MODKEY,          XKB_KEY_Return,  { .v = termcmd },   spawn },
	{ SWC_BINDING_KEY,    MODKEY,          XKB_KEY_p,       { .v = menucmd },   spawn },
	{ SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_e,       { .v = NULL },      quit },
	{ SWC_BINDING_KEY,    MODKEY,          XKB_KEY_k,       { .v = NULL },      focus_next },
	{ SWC_BINDING_KEY,    MODKEY,          XKB_KEY_j,       { .v = NULL },      focus_prev },
	{ SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_q,       { .v = NULL },      kill_sel },
	{ SWC_BINDING_KEY,    MODKEY,          XKB_KEY_space,   { .v = NULL },      toggle_float },
	{ SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_space,   { .v = NULL },      toggle_float_global },
	{ SWC_BINDING_KEY,    MODKEY,          XKB_KEY_l,       { .i = 50 },        master_resize },
	{ SWC_BINDING_KEY,    MODKEY,          XKB_KEY_h,       { .i = -50 },       master_resize },
	{ SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_k,       { .v = NULL },      master_next },
	{ SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_j,       { .v = NULL },      master_prev },
	{ SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_Return,  { .v = NULL },      zoom },
  { SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_i,       { .i = +1 },        incnmaster },
  { SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_d,       { .i = -1 },        incnmaster },

	/* workspace */
	{ SWC_BINDING_KEY,    MODKEY,          XKB_KEY_1,       { .u = 1 },         workspace_goto },
	{ SWC_BINDING_KEY,    MODKEY,          XKB_KEY_2,       { .u = 2 },         workspace_goto },
	{ SWC_BINDING_KEY,    MODKEY,          XKB_KEY_3,       { .u = 3 },         workspace_goto },
	{ SWC_BINDING_KEY,    MODKEY,          XKB_KEY_4,       { .u = 4 },         workspace_goto },
	{ SWC_BINDING_KEY,    MODKEY,          XKB_KEY_5,       { .u = 5 },         workspace_goto },
	{ SWC_BINDING_KEY,    MODKEY,          XKB_KEY_6,       { .u = 6 },         workspace_goto },
	{ SWC_BINDING_KEY,    MODKEY,          XKB_KEY_7,       { .u = 7 },         workspace_goto },
	{ SWC_BINDING_KEY,    MODKEY,          XKB_KEY_8,       { .u = 8 },         workspace_goto },
	{ SWC_BINDING_KEY,    MODKEY,          XKB_KEY_9,       { .u = 9 },         workspace_goto },
	{ SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_1,       { .u = 1 },         workspace_moveto },
	{ SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_2,       { .u = 2 },         workspace_moveto },
	{ SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_3,       { .u = 3 },         workspace_moveto },
	{ SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_4,       { .u = 4 },         workspace_moveto },
	{ SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_5,       { .u = 5 },         workspace_moveto },
	{ SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_6,       { .u = 6 },         workspace_moveto },
	{ SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_7,       { .u = 7 },         workspace_moveto },
	{ SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_8,       { .u = 8 },         workspace_moveto },
	{ SWC_BINDING_KEY,    MODKEY|SHIFT,    XKB_KEY_9,       { .u = 9 },         workspace_moveto },

	/* mouse */
	{ SWC_BINDING_BUTTON, MODKEY,          BTN_LEFT,        { .v = NULL },      mouse_move },
	{ SWC_BINDING_BUTTON, MODKEY,          BTN_RIGHT,       { .v = NULL },      mouse_resize },
};

#endif /* CONFIG_H */
