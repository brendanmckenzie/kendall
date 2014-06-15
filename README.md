# kendall

Since there doesn't seem to be any clean providers out there for multiple domain email hosting, I started writing my own.  But I don't have the time or resources to work on it so I'll just keep it here until I do something with it.

The idea is that a list of domains is stored in a database, along with member accounts, members can have multiple aliases for multiple domains and will eventually be able to store their emails in one spot.

So far I've got the postfix configuration to receive the emails and insert them into a postgresql database.

What needs to be done:

 * A *simple* web interface
 * Sending emails from aliases
 * Folder structures
 * IMAP server with push for delivery
