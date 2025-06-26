while true; do
  sudo ryzenadj --stapm-limit=20000 --fast-limit=20000 --slow-limit=20000 --tctl-temp=85
  sleep 15
done