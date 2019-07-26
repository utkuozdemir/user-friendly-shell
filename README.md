# user-friendly-shell
Makes the Linux shell you found yourself in more user friendly.

## Usage

In a shell, run the following command:

via curl:
```bash
$ source <(curl -s https://raw.githubusercontent.com/utkuozdemir/user-friendly-shell/master/make-friendly.sh)
```

or via wget:
```bash
$ source <(wget -qO- -s https://raw.githubusercontent.com/utkuozdemir/user-friendly-shell/master/make-friendly.sh)
```

Finally, run the following command:
```bash
$ source ~/.bashrc
```

Tested only on _Ubuntu 18.04_ and _bash_.

## Future Work

- Support more OSs/distros/shells.
- Add checks for OSs/distros/shells.
- Introduce non-sudo mode.
