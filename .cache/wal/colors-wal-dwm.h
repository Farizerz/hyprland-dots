static const char norm_fg[] = "#88c0d8";
static const char norm_bg[] = "#010D15";
static const char norm_border[] = "#5f8697";

static const char sel_fg[] = "#88c0d8";
static const char sel_bg[] = "#405169";
static const char sel_border[] = "#88c0d8";

static const char urg_fg[] = "#88c0d8";
static const char urg_bg[] = "#0F627C";
static const char urg_border[] = "#0F627C";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
