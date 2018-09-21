// Import Phoenix's Socket Library
import { Socket } from 'phoenix';

// Utility functions

// When we join the channel, do this
const onJoin = (res, channel) => {
  console.log("Chat join");
  document.querySelectorAll(".chat-send").forEach(el => {
    el.addEventListener("click", event => {
      console.log("clicked");
      event.preventDefault();
      const chatInput = document.querySelector(".chat-input");
      const message = chatInput.value;
      const author = document.querySelector(".author-input").value;
      console.log(message, author);
      pushMessage(channel, author, message);
      chatInput.value = ""
    });
  });
}

// Push a new message to the server
const pushMessage = (channel, author, message) => {
  channel
    .push("new_message", { author, message })
    .receive("ok", res => console.log("Message sent!"))
    .receive("error", res => console.log("Failed to send message:", res))
}

// Add a message to the list of chat message
const addMessage = (author, message) => {
  const chatLog = document.querySelector(".chat-messages");
  chatLog.innerHTML += `<li>
    <span class="author">&lt;${author}&gt;</span>
    <span class="message">${message}</span>
  </li>`
}

// Next, create a new Phoenix Socket to reuse
const socket = new Socket("/socket");

// Connect to the socket itself
socket.connect();

const connect = socket => {
  // Only connect to the socket if the chat channel actually exists!
  const enableLiveChat = document.getElementById("enable-chat-channel");
  if(!enableLiveChat) {
    return;
  }

  //Create a channel to handle joining/sending/receiving
  const channel = socket.channel("chat:lobby");

  //Next, join the topic on the channel!
  channel
    .join()
    .receive("ok", res => onJoin(res, channel))
    .receive("error", res => console.log("Failed to join channel:", res));

  channel.on("new_message", ({ author, message }) => {
    addMessage(author, message)
  })
};





// Finally, export the socket to be imported in app.js
export default { connect };