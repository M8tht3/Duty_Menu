PUT  THIS IN YOUR SERVER.CFG - MAKE A FOLDER IN YOUR RESOURCES FOLDER NAME IT DUTY GO TO YOUR SERVER.CFG AND DO ENSURE DUTY

add_ace group.lspd "lspd.duty" allow
add_ace group.lapd "lapd.duty" allow
add_ace group.dhs "dhs.duty" allow
add_ace group.sahp "sahp.duty" allow
add_ace group.leo "leo.access" allow

add_principal identifier.discord:DISCORD ID HERE group.lspd DO THIS FOR ALL DEPARTMENTS
add_principal identifier.discord:DISCORD ID HERE group.leo
