# Environment Variables

Linux does have a similar concept to the Windows environment variables. In Linux, environment variables are used to define temporary values for current session and all processes started from current session can access these values. The PATH variable is one of these environment variables and it is used to store directories where executables are located.

However, unlike Windows where environment variables are stored in a central location and can be edited directly through the System Properties window, Linux environment variables are typically set in shell initialization files like .bashrc, .bash_profile, or .profile. These files are executed when a new shell is started, and any exports or variable definitions made in these files are made available to the shell and any programs started from it.

So, while you can’t edit the PATH variable in a central location like you can in Windows, you can add directories to the PATH in any shell initialization file and they will be available in every new shell session. This is similar to adding directories to the PATH in the System Environment Variables window in Windows.

Remember to run source ~/.bashrc (or the appropriate file) after editing it, to apply the changes to the current shell session. Otherwise, the changes will only take effect in new shell sessions.
