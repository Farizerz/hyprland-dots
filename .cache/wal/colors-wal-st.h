const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#010D15", /* black   */
  [1] = "#0F627C", /* red     */
  [2] = "#405169", /* green   */
  [3] = "#08548B", /* yellow  */
  [4] = "#106994", /* blue    */
  [5] = "#0D6FAC", /* magenta */
  [6] = "#2E76B3", /* cyan    */
  [7] = "#88c0d8", /* white   */

  /* 8 bright colors */
  [8]  = "#5f8697",  /* black   */
  [9]  = "#0F627C",  /* red     */
  [10] = "#405169", /* green   */
  [11] = "#08548B", /* yellow  */
  [12] = "#106994", /* blue    */
  [13] = "#0D6FAC", /* magenta */
  [14] = "#2E76B3", /* cyan    */
  [15] = "#88c0d8", /* white   */

  /* special colors */
  [256] = "#010D15", /* background */
  [257] = "#88c0d8", /* foreground */
  [258] = "#88c0d8",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
