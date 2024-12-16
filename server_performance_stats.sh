#!/bin/bash


get_cpu_stat()
{
	top -bn1 | grep "%Cpu(s):" | cut -d ',' -f 4 | awk '{print "Cpu usage: " 100-$1 "%"}'
}

get_memory_stat()
{
	top -bn1 | grep "MiB Mem :" | cut -d ',' -f 5 | awk '{print "Memory usage: " $1 " MiB"}'
}

get_top_proc()
{
	ps aux --sort -%mem | head -n 6 | awk '{print $1 "\t" $2 "\t" $4 "\t" $11}'
}

get_disk_usage()
{
	df -h | grep "/" -w | awk '{printf "Disk spce:\n" "Total: %sG\nUsed: %s (%.2f%%)\nFree: %s (%.2f%%)\n",$3 + $4, $3, $3/($3+$4) * 100, $4, $4/($3+$4) * 100}'
}

get_top_mem_proc()
{
	ps aux --sort -%cpu | head -n 6 | awk '{print $1 "\t" $2 "\t" $3 "\t" $11}'
}

main()
{
echo "======================="
echo "Server Perfomance Stats"
echo "======================="
echo ""
	get_cpu_stat
echo ""
	get_memory_stat
echo ""
	get_top_proc
echo ""
	get_disk_usage
echo ""
	get_top_mem_proc
echo ""
echo "======================="
echo "OS Version: $(lsb_release -d | cut -f2-)"
echo "Uptime: $(uptime -p)"
echo "Logged in Users: $(who | wc -l)"
echo "======================="

}

main
