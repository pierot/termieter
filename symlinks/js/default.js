function dotjs_create_cookie(name, value, days) {
  if (days) {
    var date = new Date();

    date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));

    var expires = "; expires=" + date.toGMTString();
  } else 
    var expires = "; expires=Monday, 19-Aug-1996 05:00:00 GMT";

  document.cookie = name + "=" + value + expires + "; path=/";
}

function dotjs_read_cookie(name) {
  var nameEQ = name + "=";
  var ca = document.cookie.split(';');

  for(var i = 0; i < ca.length; i++) {
    var c = ca[i];

    while (c.charAt(0) == ' ') 
      c = c.substring(1, c.length);

    if (c.indexOf(nameEQ) == 0) 
      return c.substring(nameEQ.length, c.length);
  }

  return null;
}

function dotjs_erase_cookie(name) {
  while (name.charAt(0) == ' ') 
    name = name.substring(1, name.length);

  dotjs_create_cookie(name, " ", -1);
  dotjs_create_cookie(" " + name, " ", -1);
}
