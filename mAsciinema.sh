#!/bin/bash
 E='echo -e';    # -e включить поддержку вывода Escape последовательностей
 e='echo -en';   # -n не выводить перевод строки
 c="+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+"
 trap "R;exit" 2 #
    ESC=$( $e "\e")
   TPUT(){ $e "\e[${1};${2}H" ;}
  CLEAR(){ $e "\ec";}
# 25 возможно это
  CIVIS(){ $e "\e[?25l";}
# это цвет текста списка перед курсором при значении 0 в переменной  UNMARK(){ $e "\e[0m";}
MARK(){ $e "\e[1;45m";}
# 0 это цвет списка
 UNMARK(){ $e "\e[0m";}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Эти строки задают цвет фона ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  R(){ CLEAR ;stty sane;CLEAR;};                 # в этом варианте фон прозрачный
 HEAD(){ for (( a=2; a<=40; a++ ))
  do
   TPUT $a 1
        $E "\033[1;35m\xE2\x94\x82                                                                                                                         \xE2\x94\x82\033[0m";
  done
 TPUT 3 3
        $E "\033[1;35m*** asciinema *** рекордер терминальной сессии\033[0m";
 TPUT 4 7
        $E "\033[2masciinema позволяет легко записывать терминальные сессии и воспроизводить их в терминале, а также в веб-браузере.\033[0m";
 TPUT 5 1
        $E "\033[1;35m$c\033[0m";
 TPUT 14 3
        $E "\033[36mAvailable options:\033[90m                                                            Доступные опции:\033[0m";
 TPUT 33 3
        $E "\033[36mAvailable options:\033[90m                                                            Доступные опции:\033[0m";
 TPUT 38 3
        $E "\033[32mUp \xE2\x86\x91 \xE2\x86\x93 Down Select Enter\033[0m";
 MARK;TPUT 1 1
        $E "$c";UNMARK;}
   i=0; CLEAR; CIVIS;NULL=/dev/null
# 32 это расстояние сверху и 48 это расстояние слева
   FOOT(){ MARK;TPUT 41 1
        $E "$c";UNMARK;}
# это управляет кнопками ввер/хвниз
 i=0; CLEAR; CIVIS;NULL=/dev/null
#
 ARROW(){ IFS= read -s -n1 key 2>/dev/null >&2
           if [[ $key = $ESC ]];then
              read -s -n1 key 2>/dev/null >&2;
              if [[ $key = \[ ]]; then
                 read -s -n1 key 2>/dev/null >&2;
                 if [[ $key = A ]]; then echo up;fi
                 if [[ $key = B ]];then echo dn;fi
              fi
           fi
           if [[ "$key" == "$($e \\x0A)" ]];then echo enter;fi;}
  M0(){ TPUT  6 3; $e " Установка                                                                                  \033[32minstall                   \033[0m";}
  M1(){ TPUT  7 3; $e " Oбзор                                                                                      \033[32mSynopsis                  \033[0m";}
  M2(){ TPUT  8 3; $e " Окружающая среда                                                                           \033[32mEnvironment               \033[0m";}
  M3(){ TPUT  9 3; $e " Ошибки                                                                                     \033[32mBugs                      \033[0m";}
  M4(){ TPUT 10 3; $e " Автор                                                                                      \033[32mAuthor                    \033[0m";}
  M5(){ TPUT 11 3; $e " Версия                                                                                     \033[32m   --version              \033[0m";}
  M6(){ TPUT 12 3; $e "\033[1;36m--- Commands ------------------------------------------------------------------------------ \033[90mКоманды ------------------\033[0m";}
  M7(){ TPUT 13 3; $e " Запись терминальной сессии                                                                 \033[36m rec                      \033[0m";}
#
  M8(){ TPUT 15 3; $e " Включить stdin (keyboard) запись (см. ниже)                                                \033[32m   --stdin                \033[0m";}
  M9(){ TPUT 16 3; $e " Приходите к существующей записи                                                            \033[32m   --append               \033[0m";}
 M10(){ TPUT 17 3; $e " Сохраните выход сырья STDOUT, без информации о сроках или других метаданных                \033[32m   --raw                  \033[0m";}
 M11(){ TPUT 18 3; $e " Переписать запись, если она уже существует                                                 \033[32m   --overwrite            \033[0m";}
 M12(){ TPUT 19 3; $e " Укажите команду для записи, по умолчанию до \$SHELL                                         \033[32m-c --command=<command>    \033[0m";}
 M13(){ TPUT 20 3; $e " Список переменных среды для захвата, по умолчанию для SHELL,TERM                           \033[32m-e --env=<var-names>      \033[0m";}
 M14(){ TPUT 21 3; $e " Укажите название ансикаста                                                                 \033[32m-t --title=<title>        \033[0m";}
 M15(){ TPUT 22 3; $e " Ограничение неактивности терминала к максимуму <sec> секунд</sec>                          \033[32m-i --idle-time-limit=<sec>\033[0m";}
 M16(){ TPUT 23 3; $e " Ответ «да» на все подсказки (например, загрузите подтверждение)                            \033[32m-y --yes                  \033[0m";}
 M17(){ TPUT 24 3; $e " Будьте спокойны, подавляйте все уведомления/предупреждения (как раз -y)                    \033[32m-q --quiet                \033[0m";}
 M18(){ TPUT 25 3; $e " Воспроизведение записанного ассикаста в терминале                                          \033[36m play                     \033[0m";}
 M19(){ TPUT 26 3; $e " Доступны следующие клавиши:                                                                                          ";}
 M20(){ TPUT 27 3; $e " Игра из локального файла:                                                                                            ";}
 M21(){ TPUT 28 3; $e " Игра с URL HTTP(S):                                                                                                  ";}
 M22(){ TPUT 29 3; $e " Игра с сайта asciicast URL                                                                                           ";}
 M23(){ TPUT 30 3; $e " Игра от stdin:                                                                                                       ";}
 M24(){ TPUT 31 3; $e " Игра от IPFS:                                                                                                        ";}
 M25(){ TPUT 32 3; $e " Распечатать полный выход записанного аскциаста до терминала                                \033[32mcat <filename>            \033[0m";}
#
 M26(){ TPUT 34 3; $e " Ограничение повторного использования терминала неактивность к максимуму <sec> секунд</sec> \033[32m-i --idle-time-limit=<sec>\033[0m";}
 M27(){ TPUT 35 3; $e " Скорость воспроизведения (может быть дробной)                                              \033[32m-s --speed=<factor>       \033[0m";}
 M28(){ TPUT 36 3; $e " Загрузка                                                                                   \033[36m upload                   \033[0m";}
 M29(){ TPUT 37 3; $e " Связать свой идентификатор установки с учетной записью пользователя                        \033[36m auth                     \033[0m";}
#
 M30(){ TPUT 39 3; $e " Выход                                                                                      \033[32m Exit                     \033[0m";}
LM=30
   MENU(){ for each in $(seq 0 $LM);do M${each};done;}
    POS(){ if [[ $cur == up ]];then ((i--));fi
           if [[ $cur == dn ]];then ((i++));fi
           if [[ $i -lt 0   ]];then i=$LM;fi
           if [[ $i -gt $LM ]];then i=0;fi;}
REFRESH(){ after=$((i+1)); before=$((i-1))
           if [[ $before -lt 0  ]];then before=$LM;fi
           if [[ $after -gt $LM ]];then after=0;fi
           if [[ $j -lt $i      ]];then UNMARK;M$before;else UNMARK;M$after;fi
           if [[ $after -eq 0 ]] || [ $before -eq $LM ];then
           UNMARK; M$before; M$after;fi;j=$i;UNMARK;M$before;M$after;}
   INIT(){ R;HEAD;FOOT;MENU;}
     SC(){ REFRESH;MARK;$S;$b;cur=`ARROW`;}
# Функция возвращения в меню
     ES(){ MARK;$e " ENTER = main menu ";$b;read;INIT;};INIT
  while [[ "$O" != " " ]]; do case $i in
# Здесь необходимо следить за двумя перепенными 0) и S=M0 Они должны совпадать между собой и переменной списка M0().
  0) S=M0 ;SC;if [[ $cur == enter ]];then R;echo "
    Официальный представитель предоставил N методов установки, соответствующих различным дистрибутивам Linux, но здесь по-прежнему рекомендуется использовать для
 установки pip3. Необходимо пояснить, что для установки таким образом требуется Python 3. Похоже, что сейчас проектов Python становится все больше и больше. 2.7 был 
 заброшен, и это действительно общая тенденция.Команда установки очень проста, а именно:
 sudo apt install python3-pip
 sudo pip3 install asciinema
#
 sudo apt-add-repository ppa:zanchey/asciinema && sudo apt-get update && sudo apt-get install asciinema
#
 sudo snap install asciinema --classic
#
 git clone https://github.com/asciinema/asciinema.git
 cd asciinema
 sudo python3 -m asciinema --version
";ES;fi;;
  1) S=M1 ;SC;if [[ $cur == enter ]];then R;echo " asciinema command [options] [args]";ES;fi;;
  2) S=M2 ;SC;if [[ $cur == enter ]];then R;echo "
 ASCIINEMA_API_URL
 Эта переменная позволяет пересчитать URL-адрес asciinema-server который по умолчанию на: https://asciinema.org
 в случае, если вы управляете своим собственным: asciinema-server в‐ stance

 ASCIINEMA_CONFIG_HOME
 Эта переменная позволяет переопределять положение каталога config. По умолчанию месторасположение \\XDG_CONFIG_HOME/asciinema (когда \\XDG_CONFIG_HOME установлен)
 или \\HOME/.config/asciinema
";ES;fi;;
  3) S=M3 ;SC;if [[ $cur == enter ]];then R;echo " Смотрите проблемы на GitHub: https://github.com/asciinema/asciinema/issues";ES;fi;;
  4) S=M4 ;SC;if [[ $cur == enter ]];then R;echo "
 Ведущий разработчик asciinema — Марцин Кулик.
 Список всех участников смотрите здесь: https://github.com/asciinema/asciinema/contributors
 Эта страница руководства была написана Марцином Куликом с помощью Курта Пфайфле.
";ES;fi;;
  5) S=M5 ;SC;if [[ $cur == enter ]];then R;echo " asciinema --version";ES;fi;;
  6) S=M6 ;SC;if [[ $cur == enter ]];then R;echo " asciinema состоит из нескольких команд, подобных git, apt-get или brew.
 Когда вы запускаете asciinema без аргументов, отображается сообщение справки, в котором перечислены все доступные команды с их параметрами.";ES;fi;;
  7) S=M7 ;SC;if [[ $cur == enter ]];then R;echo -e "
\e[32m asciinema rec first.cast\e[0m
 вы начнете новый сеанс записи. Записываемая команда (процесс) может быть указана с опцией -c (см. ниже), и по умолчанию
 \$SHELL, что вам нужно в большинстве случаев.
    Запись заканчивается, когда вы выходите из оболочки (нажмите Ctrl+D или введите exit). Если записываемый процесс не является оболочкой, то запись завершается,
 когда процесс завершается это.
    Если аргумент имени файла опущен, то (после запроса подтверждения) результирующий asciicast загружается на asciinema-сервер:
 https://github.com/asciinema/asciinema-server (по умолчанию asciinema.org), где его можно посмотреть и поделиться им.
    Если указан аргумент имени файла, результирующая запись (называемая asciicast (doc/asciicast-v2.md)) сохраняется в локальном файле. Позже его можно будет
 воспроизвести с asciinema play <имя файла> и/или загруженным на сервер asciinema с asciinema upload <имя файла>.
    ASCIINEMA_REC=1 добавляется к записанным переменным среды процесса. Это может использоваться файлом конфигурации вашей оболочки (.bashrc, .zshrc) для изменения
 подсказки или воспроизводить звук при записи оболочки.
    Запись стандартного ввода позволяет записывать все символы, введенные пользователем в текущей записанной оболочке. Это может быть использовано игроком. Hапример,
 asciinema-player: https://github.com/asciinema/asciinema-player, для отображения нажатых клавиш. Потому что это, по сути, ведение журнала ключей (применительно к
 одной оболочке в пределах одной оболочки stance, по умолчанию он отключен, и его необходимо явно включить с помощью параметра –stdin.
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Вы можете записывать и загружать за один шаг, опуская имя файла:
 asciinema rec
 Когда запись будет завершена, вас попросят подтвердить загрузку, поэтому без вашего согласия ничего никуда не отправляется.
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Обратите внимание, что после выполнения этой команды весь ваш следующий ввод и вывод будет записан в указанный файл, а эффект записи синхронизируется с временем
 ввода и вывода в это время.
 Когда запись закончится, нажмите сочетание клавиш
 Ctrl + D или введите exit
";ES;fi;;
  8) S=M8 ;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
  9) S=M9 ;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
 10) S=M10;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
 11) S=M11;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
 12) S=M12;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
 13) S=M13;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
 14) S=M14;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
 15) S=M15;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
 16) S=M16;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
 17) S=M17;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
 18) S=M18;SC;if [[ $cur == enter ]];then R;echo -e "
 Эта команда воспроизводит данное asciicast (как записан rec команда) непосредственно в вашем терминале:
\e[32m asciinema play first.cast\e[0m
";ES;fi;;
 19) S=M19;SC;if [[ $cur == enter ]];then R;echo "
 Space - toggle pause - шаг за записью кадра в то время (при отмене),
 Ctrl+C               - выход.
";ES;fi;;
 20) S=M20;SC;if [[ $cur == enter ]];then R;echo " asciinema play /path/to/asciicast.cast";ES;fi;;
 21) S=M21;SC;if [[ $cur == enter ]];then R;echo "
 asciinema play https://asciinema.org/a/22124.cast
 asciinema play http://example.com/demo.cast
";ES;fi;;
 22) S=M22;SC;if [[ $cur == enter ]];then R;echo "
 (requires <link rel="alternate" type="application/x-asciicast" href="/my/ascii.cast"> in page's HTML):
 asciinema play https://asciinema.org/a/22124
 asciinema play http://example.com/blog/post.html
";ES;fi;;
 23) S=M23;SC;if [[ $cur == enter ]];then R;echo "
 cat /path/to/asciicast.cast | asciinema play -
 ssh user@host cat asciicast.cast | asciinema play -
";ES;fi;;
 24) S=M24;SC;if [[ $cur == enter ]];then R;echo " asciinema play dweb:/ipfs/QmNe7FsYaHc9SaDEAEXbaagAzNw9cH7YbzN4xV7jV1MCzK/ascii.cast";ES;fi;;
 25) S=M25;SC;if [[ $cur == enter ]];then R;echo "
    В то время как asciinema играет воспроизводит записанную сессию с использованием информации о сроках, сохраненной в аскициате, асинема cat сваливает полный
 выход (включая все escape последовательности) к терминалу немедленно:
 asciinema cat existing.cast >output.txt
 дает такой же результат, как запись через asciinema rec -raw вывода. Ткст
";ES;fi;;
 26) S=M26;SC;if [[ $cur == enter ]];then R;echo "
 Или с нормальной скоростью, но с простое время ограничено 2 секунды:
 asciinema play -i 2 first.cast
 Вы можете пройти -i 2 to asciinema rec также, установить его навсегда на запись. Ограничение времени Idle делает записи гораздо интереснее смотреть, попробуйте.
";ES;fi;;
 27) S=M27;SC;if [[ $cur == enter ]];then R;echo "
 повторите его с двойной скоростью:
 asciinema play -s 2 first.cast
";ES;fi;;
 28) S=M28;SC;if [[ $cur == enter ]];then R;echo -e "
    Загрузите записанные аскциасты на сайт asciinema.org.
 Эта команда загружает данное asciicast (записано rec команд) на asciinema.org, где его можно смотреть и делиться.
 asciinema rec demo.cast + asciinema играть demo.cast + asciinema загрузить демо. cast - это хороший комбо, если вы хотите просмотреть аскиз, прежде чем публиковать
 asciinema.org
    Приведенное выше загружает его на: https://asciinema.org, который является экземпляром asciinema-server по умолчанию https://github.com/asciinema/asciinema-server
 и печатает секретная ссылка, которую вы можете использовать для просмотра записи в веб-браузере.
    Если вы хотите посмотреть и поделиться им в Интернете, загрузите его:
\e[32m asciinema upload first.cast\e[0m
";ES;fi;;
 29) S=M29;SC;if [[ $cur == enter ]];then R;echo -e "
    Связать свой идентификатор установки с учетной записью пользователя asciinema.org.
    Если вы хотите управлять своими записями (изменить название / тема, удалить) на asciinema.org вам нужно связать свой «установить ID» с учетной записью
 пользователя asciinema.org. Эта команда отображает URL, чтобы открыть в веб-браузере, чтобы сделать это. Возможно, вам придется сначала войти в систему.
    Установить ID является случайным ID (UUID v4 (https://ru.wikipedia.org/wiki/Universally_unique_identifier) генерируется локально, когда вы запускаете asciinema
 для первого время, и сохраненный на \$HOME/.config/asciinema/install-id Это цель состоит в том, чтобы подключить местную машину с загруженными записями, так что они
 могут позже быть связаны с аккаунтом asciinema.org. Таким образом, мы отключаем загрузку с создания учетной записи, позволяя им случиться в любом порядке.
    Примечание: Новый идентификатор установки генерируется на каждом аккаунте пользователя машины и системы, на котором вы используете asciinema, чтобы сохранить все
 записи под одним asciinema.org учетная запись вам нужно запустить asciinema auth на всех этих машинах.
    Примечание: версии asciinema до 2.0 запутанно называют установить ID как “API token”.
\e[32m asciinema auth first.cast\e[0m
";ES;fi;;
 30) S=M30;SC;if [[ $cur == enter ]];then R;exit 0;fi;;
 esac;POS;done
