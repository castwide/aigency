Host *
    ProxyCommand nc -X connect -x egress:3128 %h %p
