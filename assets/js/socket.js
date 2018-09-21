// Import Phoenix's Socket Library
import { Socket } from 'phoenix';

//Utility functions


// Next, create a new Phoenix Socket to reuse
const socket = new Socket('/socket');

// Connect to the socket itself
socket.connect();

export default socket;