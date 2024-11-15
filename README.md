GREP HERE
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

This plugin defines a command and mappings to quickly list all occurrences of
the last search pattern, passed pattern, current word or selection in the
quickfix list. This is useful to get a somewhat persistent list of matches
that act like bookmarks, so you can recall them later (when your search
pattern has changed).

### HOW IT WORKS

The plugin uses :vimgrep over the current buffer.

### SOURCE

Inspiration for this plugin vimtip #483: Using GREP for a "list occurrences" and quickfix help
command. http://vim.wikia.com/wiki/Search_using_quickfix_to_list_occurrences

    command GREP :execute 'grep '.expand('<cword>') expand('%') | :copen | cc

### SEE ALSO

- The GrepCommands.vim plugin ([vimscript #4173](http://www.vim.org/scripts/script.php?script_id=4173)) provides additional grep
  commands covering arguments, buffers, windows and tab pages.
- The SearchPosition.vim plugin ([vimscript #2634](http://www.vim.org/scripts/script.php?script_id=2634)) shows the relation of the
  cursor position to the other matches of the search pattern, and provides
  similar mappings. Like the quickfix list, it can provide an orientation of
  where and how many matches there are.

### RELATED WORKS

- outline ([vimscript #1947](http://www.vim.org/scripts/script.php?script_id=1947)) creates a custom view of the file based on regex,
  in a scratch buffer
- ttoc ([vimscript #2014](http://www.vim.org/scripts/script.php?script_id=2014)) is based on outline and creates a regexp-based table
  of contents of the current buffer
- qlist (https://github.com/romainl/vim-qlist) persists :ilist (and related)
  in the quickfix list, so it works like :GrepHere, but is also covering any
  included files

USAGE
------------------------------------------------------------------------------

    :[range]GrepHere [{pattern}]
    :[range]GrepHere /{pattern}/[g][j]
    :[range]GrepHereAdd [{pattern}]
    :[range]GrepHereAdd /{pattern}/[g][j]
                            Grep the passed pattern (or last search pattern if
                            omitted) in (line in [range] of) the current file (or
                            the current entry of the quickfix list).

    ALT-N                   Grep the last search pattern in the current file
                            and show matching lines in the quickfix window (but
                            don't go there).
                            This is similar to [N defined by
                            FindOccurrence.vim, but uses the quickfix list
                            instead of just printing all matching lines.

    ALT-M                   Grep the current whole word under the cursor in the
                            current file and show matching lines in the quickfix
                            window (but don't go there).
                            Only whole keywords are searched for, like with the
                            star command.
                            This is similar to [I defined by
                            FindOccurrence.vim, but uses the quickfix list
                            instead of just printing all matching lines.
    g_ALT-M                 Grep the current word under the cursor in the current
                            file and show matching lines in the quickfix window
                            (but don't go there).
                            Also finds contained matches, like gstar.
    {Visual}ALT-M           Grep the selected text in the current file and show
                            matching lines in the quickfix window (but don't go
                            there).

                            Imagine 'M' stood for "more occurrences".
                            These mappings reuse the last used <cword> when issued
                            on a blank line.

    ,_ALT-M                 Grep the current whole (i.e. delimited by whitespace)
                            WORD under the cursor in the current file and show
                            matching lines in the quickfix window (but don't go
                            there).
    g,_ALT-M                Grep the current WORD under the cursor in the current
                            file and show matching lines in the quickfix window
                            (but don't go there).
                            Also finds contained matches, like gstar.
                            These mappings reuse the last used <cWORD> when issued
                            on a blank line.

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-GrepHere
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim GrepHere*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.036 or
  higher.
- Requires the GrepCommands.vim plugin ([vimscript #4173](http://www.vim.org/scripts/script.php?script_id=4173)), version 1.02 or
  higher.

CONFIGURATION
------------------------------------------------------------------------------

For a permanent configuration, put the following commands into your vimrc:

The :GrepHere command without arguments lists all occurrences, and (other
than the ALT-SHIFT-N mapping), jumps to the first occurrence. You can change
that via:

    let g:GrepHere_EmptyCommandGrepFlags = 'g'

When you provide any arguments to :GrepHere, provide the flags there, if
desired.

By default, the mappings list all occurrences in a line and do not jump to the
first match; you can adapt the behavior by removing some of the :vimgrep
flags:

    let g:GrepHere_MappingGrepFlags = 'gj'

If you want to use different mappings, map your keys to the
&lt;Plug&gt;(GrepHere...) mapping targets _before_ sourcing the script (e.g. in your
vimrc):

    nmap <Leader>N <Plug>(GrepHereCurrent)
    nmap <Leader>M <Plug>(GrepHereWholeCword)
    nmap <Leader>gM <Plug>(GrepHereCword)
    nmap <Leader>W <Plug>(GrepHereWholeCWORD)
    nmap <Leader>gW <Plug>(GrepHereCWORD)
    vmap <Leader>M <Plug>(GrepHereCword)

LIMITATIONS
------------------------------------------------------------------------------

- Unnamed buffers cannot be searched via :vimgrep, resulting in "E32: no
  file name".

### CONTRIBUTING

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-GrepHere/issues or email (address below).

HISTORY
------------------------------------------------------------------------------

##### 1.20    10-Nov-2024
- ENH: Add [g],&lt;A-M&gt; variants of [g]&lt;A-M&gt; that use (whole) WORD instead of
  word.

__You need to update to ingo-library ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)) version 1.036!__

##### 1.11    29-Nov-2016
- ENH: Allow [range] for :GrepHere.
- Add dependency to ingo-library ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)).

__You need to separately install ingo-library ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)) version
  1.012 (or higher)!__

__You need to upgrade to GrepCommands.vim plugin ([vimscript #4173](http://www.vim.org/scripts/script.php?script_id=4173)),
  version 1.02 or higher!__

##### 1.10    06-Sep-2012
- Make default flags for an empty :GrepHere command configurable via
g:GrepHere\_EmptyCommandGrepFlags. Default to 'g': List all occurrences, jump
to first occurrence.

##### 1.00    24-Aug-2012
- First published version.

##### 0.01    11-Jun-2003
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2003-2024 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat &lt;ingo@karkat.de&gt;
