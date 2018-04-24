#!/bin/sh
# add this to your bitbar directory
# don't forget to chmod +x


# width and characters for the progress bars
# feel free to configure these
width=30
fill_char="█"
empty_char="▁"


# bitbar parameters
# use a monospace font if you want the percentages to be right-aligned
bitbar="size=10 color=#ffffff font='Fantasque Sans Mono'"
## See Font Book.app's Fixed Width collection for what you can use
## you can also download this font for free and drag it into Font Book.app.
## https://github.com/belluzj/fantasque-sans/releases/latest




# all of the calculations are done using unix timestamps from date(1)

# mac uses bsd's date(1)
# whenever we set a date, make sure to add -j so it doesn't change the clock

# we use `date -j %m%d0000 +%s` to get the start timestamp, %Y is implied
# then we use `date -jr $start -v +1y/+1m/+1d +%s` to get the ending timestamp
# then we calculate the percentage with (now - start) / (end - start)

now=$(date +%s)

Y=$(date +%Y)
Y_start=$(date -j 01010000 +%s)
Y_end=$(date -jr $Y_start -v +1y +%s)
Y_progress=$(
    echo "($now - $Y_start) * 100 / ($Y_end - $Y_start)" | bc -l
)

m=$(date +%m)
m_start=$(date -j $(date +%m)010000 +%s)
m_end=$(date -jr $m_start -v +1m +%s)
m_progress=$(
    echo "($now - $m_start) * 100 / ($m_end - $m_start)" | bc -l
)

d=$(date +%d)
d_start=$(date -j $(date +%m%d)0000 +%s)
d_end=$(date -jr $d_start -v +1d +%s)
d_progress=$(
    echo "($now - $d_start) * 100 / ($d_end - $d_start)" | bc -l
)


# padding to align progress bar and text
# Y-m-d = 10 + 2 spaces + 2 digits + percent sign = 15
# progress bar width - 15 = padding
padding=$(printf %$((width-15))s "")


# round function
round() { printf %.0f "$1"; }

# progress bar display function
progress() {
    filled=$(round $(echo "$1 * $width / 100" | bc -l))
    empty=$((width - filled))
    # repeat the characters using printf
    printf "$fill_char%0.s" $(seq $filled)
    printf "$empty_char%0.s" $(seq $empty)
}


# output to bitbar
# first line
echo "$Y-$m-$d: $(round $d_progress)% | $bitbar size=12"
echo ---
# day + progress bar
echo "$Y-$m-$d $padding $(round $d_progress)%   | $bitbar"
echo "$(progress $d_progress)                   | $bitbar"
echo ---
# month + progress bar
echo "$Y-$m    $padding $(round $m_progress)%   | $bitbar"
echo "$(progress $m_progress)                   | $bitbar"
echo ---
# year + progress bar
echo "$Y       $padding $(round $Y_progress)%   | $bitbar"
echo "$(progress $Y_progress)                   | $bitbar"
