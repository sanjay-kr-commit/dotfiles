# Flatpak Aliases

This scripts create fltapk aliases during shell startup, so u don't have to type 

	flatpak run package_name

And instead you can just type

	app_name
	
just like any normal app

To improve performce it caches those aliases into a bash file and sources it,
but if it detects change in package count than it caches those changes, so you don't have to worry about anything	

