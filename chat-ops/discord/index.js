// Setting const's

const Discord = require('discord.js');
const client = new Discord.Client();
const config = require("./config.json");

// Set prefix to "!"
const prefix = "!";

// Console Logs
client.on('ready', () => console.log("Salad'sBot Is Ready!"));
client.on('disconnect', () => console.log("Salad'sBot Is Going Offline!"));
client.on('reconnecting', () => console.log("Trying To Reconnect!"));

// Simple Ping Pong Reply
client.on('message', message => {
	if(message.content.toLowerCase() === 'ping'){
		message.channel.send('Pong! :ping_pong: ');
	}
});

// Help Message
client.on('message', message => {
	if(message.content.toLowerCase() === prefix + 'help'){
		message.reply('If you require help, contact a member of staff. :ok_hand: ');
	}
});

// Sends Welcome Message
client.on('guildMemberAdd', member => {
  // Puts the message in the member-log channel
  const channel = member.guild.channels.find('name', 'member-log');
  // Sending the welcome message
  channel.send(`Give a warm welcome to: ${member}`);
  // If the channel doesn't exist return
  if (!channel) return;
});


// Discord Bot Token
client.login(config.token);