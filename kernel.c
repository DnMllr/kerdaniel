
void kmain ()
{

    const char *str = "my first kernel";
    char *vidptr = ( char * )0xb8000; // video mem begins here.
    unsigned int i = 0;
    unsigned int j = 0;

    /*
     * this loop clears the screen
     * there are 25 lines each of 80 columns; each element takes 2 bytes
     */
    while ( j < 80 * 25 * 2 )
    {
        /* blank character */
        vidptr[ j ] = ' ';
        /* attribute-byte - light grey on black screen */
        vidptr[ j + 1 ] = 0x07;
        j += 2;
    }

    j = 0;

    while ( str[ j ] != '\0' )
    {

        // the character's ascii
        vidptr[ i ] = str[ j ];

        vidptr[ i + 1 ] = 0x07;
        ++j;
        i += 2;

    }

}
    


