#!/usr/bin/node


const args = process.argv;
const pass = args[2];

if (!pass) {
        console.log("Use "+args[1]+" <password>");
} else {
        console.log("Password is '"+pass+"'");

        console.log("Length is "+pass.length)

        regexp = '^(?=.*[a-zA-Z])(?=.*\\d)[A-Za-z\\d!#%.,]{14,}$'

        console.log("Regexp is "+regexp)

        result = pass.match(regexp);

        if (pass.match(regexp)) {
                console.log("Matches!");
        } else {
                console.log("WRONG!");
        }
}
