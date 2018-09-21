// Import the default Phoenix HTML libraries
import 'phoenix_html';

// Import the User Socket code to enable websockets
import socket from './socket';

// Import the polls channel code to enable live polling
import LivePolls from './poll';
LivePolls.connect(socket);
// Import the chat channel code to enable chat
import LiveChat from './chat';
LiveChat.connect(socket);