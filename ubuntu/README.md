# linux setup

## Change keyboard layout to ENG_US and swap Caps and Escape Keys

### script
```
rm /etc/default/keyboard
echo "# KEYBOARD CONFIGURATION FILE" >keyboard
echo "# Consult the keyboard(5) manual page.">>keyboard
echo "XKBMODEL=\"pc104\"">>keyboard
echo "XKBLAYOUT=\"us\"">>keyboard
echo "XKBVARIANT=\"\"">>keyboard
echo "XKBOPTIONS=\"caps:escape\"">>keyboard
echo "BACKSPACE=\"guess\"">>keyboard
cp -f keyboard /etc/default/keyboard
rm keyboard
```

### or just the file contents:

```
# KEYBOARD CONFIGURATION FILE" 
# Consult the keyboard(5) manual page.">
XKBMODEL=\"pc104\"">
XKBLAYOUT=\"us\"">
XKBVARIANT=\"\"">
XKBOPTIONS=\"caps:escape\"">
BACKSPACE=\"guess\"">
```
