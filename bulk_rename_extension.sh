for i in `ls *.txt`;
  do new="$(basename $i .txt).py";
  echo mv $i $new; # echo the command to be executed
done

for i in `ls *.txt`;
  do new="$(basename $i .txt).py";
  mv $i $new; # actual execution, without echo
done
