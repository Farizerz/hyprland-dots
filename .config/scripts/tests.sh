  stapm=$(sudo ryzenadj -i | grep -Po 'STAPM LIMIT\s+\|\s+\K[\d\.]+')
  fast=$(sudo ryzenadj -i | grep -Po 'PPT LIMIT FAST\s+\|\s+\K[\d\.]+')
  slow=$(sudo ryzenadj -i | grep -Po 'PPT LIMIT SLOW\s+\|\s+\K[\d\.]+')

  echo $stapm