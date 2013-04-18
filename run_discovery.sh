echo "Checking dependencies..."

if [[ "$(ruby -e 'print RUBY_VERSION')" != *The* ]] 
	then
		echo "Ruby: OK"
		ruby --version
	else
		echo "INSTALL RUBY? (Y/N): "
		read ruby_install
		if [ "$ruby_install" == 'Y' ]
 			then
				sudo apt-get install ruby1.8 ruby1.8-dev irb rdoc ri	
		fi
fi


if [[ "$(gem --version)" != *The* ]] 
	then
		echo "RubyGems: OK"
	else
		echo "INSTALL GEM? (Y/N): "
		read gem_install
		if [ "$gem_install" == 'Y' ]
 			then
				sudo apt-get install rubygems	
		fi
fi


if [[ "$(gem list)" == *json* ]] 
	then
		echo "gem json: OK"
	else
		echo "INSTALL GEM JSON PLEASE"
		echo "INSTAL JSON? (Y/N): "
		read json_install
		if [ "$json_install" == 'Y' ]
			then
				sudo gem install json_pure
		fi
fi

if [[ "$(gem list)" == *launchy* ]] 
	then
		echo "gem launchy: OK"
	else
		echo "INSTALL GEM LAUNCHY PLEASE"
		echo "INSTAL LAUNCHY? (Y/N): "
		read launchy_install
		if [ "$launchy_install" == 'Y' ]
			then
				sudo gem install launchy
		fi
fi

echo "ENTER NAME: "
read ARG_NAME

echo "ENTER FILEPATH: "
read ARG_PATH

ruby discovery.rb --name=$ARG_NAME $ARG_PATH

echo "Finish code: " $?