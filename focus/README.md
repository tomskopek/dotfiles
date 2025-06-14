# update-hosts

The idea is to block various sites. Every hour "re-block" them so that even if you unblock them manually, they get re-blocked

1. Symlink the override file (this file will replace /etc/hosts every hour)

`sudo ln -s ~/dev/dotfiles/focus/hosts.override /etc/hosts.override`

2. Give permission to the script:

`chmod +x /Users/tom/dev/dotfiles/focus/update-hosts.sh`

3. Set up a cron task

`sudo crontab -e`

Paste:

```
0 * * * * /bin/bash /Users/tom/dev/dotfiles/focus/update-hosts.sh >> /var/log/update-hosts.log 2>&1
* * * * * /bin/echo "Cron test at $(date)" >> /var/log/cron-test.log 2>&1
```
