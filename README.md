# Masternode Installation Script

# Part 1 - Sending Collateral Coins

1. Open your Windows wallet and unlock if your wallet is encrypted - MAKE SURE IT IS FULLY SYNCED WITH THE NETWORK AND STAKING IS DISABLED
2. Go to Settings -> Debug -> Console
3. Type: getnewaddress MN# (# is your masternode number you want to use. Example: MN1)
4. Send 5000 NRC to this address and wait for at least 1 confirmation
5. Go to Settings -> Debug -> Console
6. Type: getmasternodeoutputs
7. Type: createmasternodekey
7. Save your TX ID (The first number) and your Index Number (Second number, either a 1 or 0)
8. Save your generated key as well as this will be needed in your VPS as your private key
9. Save these with a notepad
10. Close the wallet
11. Move to Part 2 for now

# Part 2 - Getting your Linux VPS Started Up (Read all instructions and follow prompts closely)

1. Connect to your linux vps AS ROOT, copy and paste the following line into your VPS. Double click to highlight the entire line, copy it, and right click into Putty or Shift + Insert to paste or other button combinations depends on the shell application or your system operation.
```
bash <( curl -sL https://raw.githubusercontent.com/nodesreward/masternodescript/main/install.sh)
```
2. follow the prompts closely and don't mess it up!
3. Move to Part 3

# Part 3 - Editing your Windows Config File

1. Open masternode.conf file
2. Enter the following on one single line after the example configuration
```<alias> <ip>:49330 <private_key> <tx_id> <index>```
3. It should look something like this:
``` MN1 127.0.0.2:49330 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX X```
4. Save and close the file and restart your wallet.

# Part 4 - Starting the Masternode

1. In your wallet, go to Masternode tab
2. Click on the masternode you just created and click start
3. Enjoy! You can start this process over again for another MN on a fresh Linux VPS!

# Part 5 - Checking Masternode Status

1. After running the command in step 4, go back to your VPS
2. Enter ```cd``` to get back to your root directory
3. Enter ```nrc-cli getmasternodestatus```
4. This will tell you the status of your masternode, any questions, Join discord for help: https://discord.gg/JBWkurcVha

# Recommended Tools

- Windows Power Shell
- Putty - Easy to use and customizable SSH client.
- SuperPutty - This allows you to have multiple Putty tabs open in one window, allowing you to easily organize and switch between masternode servers.

# Recommended VPS Specification

- Linux Ubuntu 20.04 and above
- 1 GB RAM
- 2 Cores vCPU
- 20 GB SSD Disk Space

# Required

- Public IP address
- Stable internet connection 