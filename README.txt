Итак, во-первых, компилятору опцией следует указать:
-static-link-runtime-shared-libraries=true

Это находится в свойствах проекта (ctrl + alt + shift + S) во вкладке
Project Settings -> modules -> Dune2 (или как он у тебя называется) ->
Flex Compiler Settings -> Additional compiler options

Версия Flex SDK у нас 4.1. Пока всё, вроде.