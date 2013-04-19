echo "Checking dependencies..."

if [[ "$(ruby -e 'print RUBY_VERSION')" == *The* ]] 
	then
		sudo apt-get install ruby1.8 ruby1.8-dev irb rdoc ri	
fi

if [[ "$(gem --version)" == *The* ]] 
	then
		sudo apt-get install rubygems	
fi

if [[ "$(gem list)" != *json* ]] 
	then
		sudo gem install json_pure
fi

if [[ "$(gem list)" != *launchy* ]] 
	then
		sudo gem install launchy
fi

ruby discovery.rb $1 $2

echo "Finish code: " $?