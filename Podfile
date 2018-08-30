# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
inhibit_all_warnings!

target 'BrastlewarkApp' do
	# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
	use_frameworks!

	# This two libraries are used to make use of reactive programming
	pod 'RxSwift'
	pod 'RxCocoa'

	# Alamofire is the best known library for HTTP requests, it's used everywhere and its constantly being updated.
	pod 'Alamofire'

	# I chose Kingfisher to manage images because its very simple to use and it has an active community.
	# It also does the image cache work. I've used it in several projects with no issues at all.
	pod 'Kingfisher'

	# The reasons to use this libraries are the same, both were the most popular pods for the purpose i needed,
	# I saw both had recent commits and have a decent number of users. Anothe pro of these two is that they are pretty simple to use
	pod 'SideMenu'
	pod 'TTRangeSlider'
	
	target 'BrastlewarkAppTests' do
		inherit! :search_paths

		# Quick provides contexts for unit testing, really useful to separate test cases
		pod 'Quick'

		# Nimble provides expectations and matchers that help to do kinds of assertions in a really readable way.
		# Combined with Quick, tests are like reading a sentence.
		pod 'Nimble'

		# Mockingjay is used to mock server responses, it basically matches URLs and provides a mocked response.
		# Really useful to test my interactors (Actually any class that makes an API request)
		pod 'Mockingjay'

		# As i used Rx to code, i need it to test, particularly i use RxBlocking to easly test observables
		# a blocking observable lets you get the first event emitted without needing to subscribe to it
		# so its useful to test EventEmitter Doubles and view mocks which emit events through observables
		pod 'RxSwift'
		pod 'RxBlocking'
		pod 'RxNimble'
	end
end

