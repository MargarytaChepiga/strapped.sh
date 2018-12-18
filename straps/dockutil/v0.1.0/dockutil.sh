#!/bin/bash 

function strapped_dockutil() {
	# Variables to hold the deps and corresponding checks
	local __deps="dockutil "
	local __resp
	# Performing each check for each dep
	for dep in ${__deps}; do
		command -v "${dep}" &> /dev/null
		__resp=$?
		if [[ $__resp -ne 0 ]]; then
			echo "ERROR: dep ${dep} not found:"
			case "${dep}" in
			"dockutil")
				echo -e "
	Please ensure you have dockutil installed on your system 
	We reccomend using the brew strap to install dockutil 
	 brew:  
		 packages:  
			- { name: dockutil }  
"
			;;
			esac
			exit 1
		fi
	done
	# Commands that run before the routines start
	run_command "dockutil --remove all --no-restart"

	# Declaring local variables for the 'apps' routine
	local path
	local pos

	# Declaring local variables for the 'dirs' routine
	local display
	local sort
	local path
	local view
	local input=${1}

	# Initialize array iterator
	local i=0

	# performing functionality for routine 'apps'
	for ((i=0; i<$( ysh -T "${input}" -c apps ); i++)); do

		# Getting fields for routine 'apps'
		path=$( ysh -T "${input}" -l apps -i ${i} -Q path )
		pos=$( ysh -T "${input}" -l apps -i ${i} -Q pos )

		# Writing message for routine 'apps'
		pretty_print ":info:" "🚢 docking ${path}"

		# Executing the command(s) for routine 'apps'
		run_command "dockutil --add \"${path}\" --position ${pos} --no-restart"
	done


	# performing functionality for routine 'dirs'
	for ((i=0; i<$( ysh -T "${input}" -c dirs ); i++)); do

		# Getting fields for routine 'dirs'
		display=$( ysh -T "${input}" -l dirs -i ${i} -Q display )
		sort=$( ysh -T "${input}" -l dirs -i ${i} -Q sort )
		path=$( ysh -T "${input}" -l dirs -i ${i} -Q path )
		view=$( ysh -T "${input}" -l dirs -i ${i} -Q view )

		# Writing message for routine 'dirs'
		pretty_print ":info:" "🚢 docking ${path}"

		# Executing the command(s) for routine 'dirs'
		run_command "dockutil --add \"${path}\" --view ${view} --display ${display} --sort ${sort} --no-restart"
	done
	# Commands that run after the routines finish
	run_command "killall -KILL Dock"
}
