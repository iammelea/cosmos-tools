# Monitoro 

<p align="center">
  <img width="460" height="460" src="https://meleatrust.com/wp-content/uploads/2020/03/g5738.png">
</p>




---

A simple but very powerful tool for monitoring all types of Cosmos based nodes together with the Telegram application, MoniTØRØ is designed to monitor and prevent node drops before they happen. You can monitor all types of nodes from Sentrys to Validators and you can also monitor multiple nodes on the same hosts by simply specifying the RPC port of each one and running a different monitoring process for each node.
It is installed on the same hosts as the node, to be able to perform the action of restarting the node, you can also install it externally and curl to the node's RPC port. If you install it locally, you won't have to have the RPC port open.
Since I am a Cosmos Validator I always have to spend a lot of time monitoring and worrying about the proper functioning of all sentrys, seeds, Validators; to have peace of mind and know that all my validator is well connected to them and that everything works correctly on the infrastructure. 
If I'm honest, Cosmos AkA powered by Tendermint is the most stable validation software I'm currently running. I can assure you that I have run in 2 cores and 8 Ram a total of 6 different nodes of networks based on Cosmos, without experiencing problems of any kind, despite all this, we should not abandon the tracking of the nodes until we a fall alarm arrives, it is best to have a report of how many nodes are connected to each node and if the synchronization is correct throughout the day. All this is done by MoniTørø, you just have to configure the RPC ports of the node you want to track and leave your Telegram Bot data, decide how often you want to receive the message in your telegram and so it will be, it has an extra; If the node is down, restart it so you don't have to stop doing what you are doing and you can take it easier.
Since melea Validator, we are using this tool to monitor all our nodes and is quite useful for our day to day and we only want to warn you that if use it in the Validators you must take into account that if you make a stop of the node you must also stop MoniTørø, so that does not restart the node when it detects that it is stopped. Very important when moving the validator from one server to another and not wanting to double-sign. For all other tests, we found no other danger.


---

[How to setup Telegram Bot](https://github.com/iammelea/cosmos-tools/blob/master/monitoro/Telegram%20bot%20chat-ID.md)


---

For the next steps, you need to have your Telegram Bot configured, Telegram token and chat-ID.

<p align="center">
  <img width="300" height="600" src="https://meleatrust.com/wp-content/uploads/2020/03/photo_2020-03-07_20-40-20.jpg">
</p>


---

How to install MoniTØRØ


Update and download the repo from Github


$ sudo apt update && sudo apt upgrade -y

$ sudo apt install screen curl expect -y

$ git clone https://github.com/iammelea/cosmos-tools.git

$ cd cosmos-tools/monitoro


The [repository](https://github.com/iammelea/cosmos-tools/tree/master/monitoro) currently has templates for the most popular blockchain based on Cosmos and that also I am working on. 🌝

Open the base template or one of the existing ones and customize it with your data to make it work.


#chose the name of the chain / file and give permissions to run like a program.


$ chmod +x monitoro.sh

$ vi monitoro.sh

Open and edit your info inside the file


WHAT Info?


<26657> for the RPC port of the node in the case it is other.
<YOUR_TELEGRAM_TOKEN>
<YOUR_CHAT_ID>
Edit times under convenience. sleep 300 = 300 seg aKa 5 minutes
Edit the node name and add you prefer emoticons too.

The 5 parts you should pay attention to customize your MoniTØRØ

![img](https://meleatrust.com/wp-content/uploads/2020/03/g5991.png)

Need run like sudo if used " sudo systemctl" for managing the restart of the node, in case of other assistant no need sudo.


$ screen -S monitoro


$ sudo ./monitoro.sh


My personal recommendation is not to use screen after having everything configured and working, it is best to make it work with systemd as a process that starts when the server starts or restarts. 

NOTE: At the first moment of starting it, you will receive the first message via telegram indicating the peers and the state of the synchronization of the node. if it detects that the node is not working it starts it, so you must be sure that the RPC port in monitoro.sh and in the Cosmos file .gaiag/config/config.toml is the same RPCport.

NOTE 2: While the process is running, it will be repeated every few seconds as it is configured in monitoro.sh

NOTE 3: if use it in the Validators you must take into account that if you make a stop of the node you must also stop MoniTørø, so that does not restart the node when it detects that it is stopped

.end

I hope you find it useful and save you time.

# cheers



