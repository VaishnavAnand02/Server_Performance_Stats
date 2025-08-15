#!/usr/bin/env bash
set -euo pipefail

echo "===SERVER PERFORMANCE STATS==="
echo "Date: $(date)"
echo -e "\n"

echo "CPU-USAGE"
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "Cpu_usage:$cpu_usage%"
echo -e "\n"

echo "Memory-Usage"
mem_total=$(free -m | grep "Mem" | awk '{print $2}')
mem_free=$(free -m | awk '/Mem:/ {print $4}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_percent=$(free -m | awk '/Mem:/ {printf("%.2f"), $3/$2 * 100}')
echo "Memory_Total:$mem_total MB"
echo "Memory_Free:${mem_free} MB"
echo "Memory_Used:$mem_used MB"
echo "Memory_Percent:$mem_percent%"
echo -e "\n"

echo "Disk Usage"
disk_total=$(df -BM | awk '$6=="/" {print $2}')
disk_used=$(df -BM | awk '$6=="/" {print $3}')
disk_avail=$(df -BM | awk '$6=="/" {print $4}')
disk_percent=$(df -BM | awk '$6=="/" {printf("%.2f"), $3/$2 * 100}')
echo "Disk_total:$disk_total"
echo "Disk_used:$disk_used"
echo "Disk_avail:$disk_avail"
echo "Disk_percent:$disk_percent%"
echo -e "\n"

echo "Top 5 process by CPU"
ps -eo pid,comm,%cpu --sort=-%cpu |  awk 'NR==1 {print; next} {printf "%-6s %-20s %.8f\n", $1,$2,$3}' | head -n 6
echo -e "\n"

echo "Top 5 process by Memory"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
