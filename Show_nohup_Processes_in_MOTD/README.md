# Overview
I start a lot of long-running processes with `nohup` on my home server and then walk away. When logging in (or SSH'ing in) it's helpful to know which jobs are still running in the background.

This simple script finds all processes that are currently using a "nohup.out" file and adds that list to the Message of the Day (MOTD) file.

## Prerequisites
Put your baseline MOTD file (which can be empty) at `/etc/motd_BASE`.

Put this script somewhere and make it executable with `chmod +x add_nohup_to_motd.sh`.

Add a cron job as the root user with `sudo crontab -e`, format similar to `* * * * * /home/reed/Utils_and_Automations/add_nohup_to_motd.sh` (to run every minute). NOTE that you could run this as a non-root user with passwordless sudo, but it does require sudo privileges to run properly so you'll have to add "sudo" to most commands.

## Example Output
When logging into my server, I now see the OS header info:
```
Welcome to Ubuntu 24.04 LTS (GNU/Linux 6.8.0-38-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro
```
etc.

Followed by my baseline MOTD:
```
           ,-----.    
         ,'_/_|_\_`.     Beep boop, sir!
        /<<::8[O]::>\  /
       _|-----------|_
   :::|  | ====-=- |  |:::
   :::|  | -=-==== |  |:::
   :::\  | ::::|()||  /:::
   ::::| | ....|()|| |::::
       | |_________| |
       | |\_______/| |
      /   \ /   \ /   \            Welcome to <server>
      `---' `---' `---'       - All systems good, not great -
```

Followed by the list of running nohup jobs:
```
Commands currently running under nohup:

  --> sudo wget https://huggingface.co/llmware/dragon-mistral-7b-v0/resolve/main/dragon-mistral-7b-q4_k_m.gguf
  --> sudo wget https://huggingface.co/llmware/dragon-mistral-7b-v0/resolve/main/dragon-mistral-7b-q4_k_m.gguf
  --> wget https://huggingface.co/llmware/dragon-mistral-7b-v0/resolve/main/dragon-mistral-7b-q4_k_m.gguf
  --> sudo wget https://huggingface.co/llmware/dragon-llama-7b-v0/resolve/main/dragon-llama-7b-q4_k_m.gguf
  --> sudo wget https://huggingface.co/llmware/dragon-llama-7b-v0/resolve/main/dragon-llama-7b-q4_k_m.gguf
  --> wget https://huggingface.co/llmware/dragon-llama-7b-v0/resolve/main/dragon-llama-7b-q4_k_m.gguf
```

Note that there are duplicates; in this example there are 2 nohup commands running, but we get three results for each one. I'm curious to know why, but not curious enough to dig into the docs. Leave a PR if you have the answer!
