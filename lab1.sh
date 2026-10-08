#!/bin/bash

mkdir -p claude_monet/kitchen/{hot_station,cold_room}
mkdir -p claude_monet/sanitation
mkdir -p claude_monet/hall
mkdir -p claude_monet/office
mkdir -p claude_monet/cleaning

cd claude_monet/kitchen/hot_station
cat <<EOF > hot_report
Горячий цех подготовлен к проверке
Рабочие поверхности очищены
Баринов проверил порядок лично
EOF

cat <<EOF > senya_check
Сеня убрал лишние продукты
Ножи лежат на своих местах
Срок хранения мяса не нарушен
EOF

cd ../cold_room
cat <<EOF > fridge_temperature
Утром температура четыре градуса
Днём температура пять градусов
Вечером температура четыре градуса
EOF

cat <<EOF > fish_check
Федя проверил сибаса и дорадо
Свежая рыба перенесена в холодильник
Нарушений хранения рыбы нет
EOF

cd ../../sanitation
cat <<EOF > inspection_act
Проверка началась до открытия ресторана
Инспектор осмотрел кухню и зал
Повторная проверка назначена на пятницу
EOF

cat <<EOF > violations
Нарушен порядок хранения одной коробки
Нарушена маркировка контейнера с соусом
График уборки висит не на своём месте
EOF

cd ..//cleaning
cat <<EOF > cleaning_schedule
Уборка кухни проводится утром
Уборка зала проводится перед открытием
Вечером Лёва проверяет результат уборки
EOF

cd ..//hall
cat <<EOF > waiter_note
Официанты убрали столы перед проверкой
Настя проверила гостевую зону
Запасные скатерти сложены в шкаф
EOF

cd ..//office
cat <<EOF > vika_response
Вика получила акт инспектора
Замечания будут исправлены до вечера
Ответственным назначен Лёва
EOF

cd ..
cd ..
cat <<EOF > inspector_arrival
Инспектор приехал раньше назначенного времени
Баринов встретил проверку на кухне
Нагиев потребовал избежать штрафа
EOF

chmod 755 claude_monet
chmod u=rwx,g=rx,o= claude_monet/kitchen
chmod 750 claude_monet/kitchen/hot_station
chmod u=rw,g=r,o= claude_monet/kitchen/hot_station/hot_report
chmod 640 claude_monet/kitchen/hot_station/senya_check
chmod u=rwx,g=rx,o= claude_monet/kitchen/cold_room
chmod 644 claude_monet/kitchen/cold_room/fridge_temperature
chmod u=rw,g=r,o= claude_monet/kitchen/cold_room/fish_check
chmod 750 claude_monet/sanitation
chmod u=rw,g=r,o= claude_monet/sanitation/inspection_act
chmod 640 claude_monet/sanitation/violations
chmod u=rwx,g=rx,o= claude_monet/cleaning
chmod 644 claude_monet/cleaning/cleaning_schedule
chmod 755 claude_monet/hall
chmod u=rw,g=r,o=r claude_monet/hall/waiter_note
chmod u=rwx,g=rx,o= claude_monet/office
chmod 640 claude_monet/office/vika_response
chmod u=rw,g=r,o= inspector_arrival

git add .
git commit -m "1 задание с деревом и 2 задание с правами"

cp inspector_arrival claude_monet/office/arrival_copy
cp -r claude_monet/cleaning claude_monet/sanitation/cleaning_backup
ln -s claude_monet/sanitation/inspection_act inspection_link
cd claude_monet/kitchen
ln -s ../sanitation sanitation_access
cd ..
cd ..
ln claude_monet/sanitation/inspection_act claude_monet/sanitation/act_duplicate
cat claude_monet/kitchen/hot_station/hot_report claude_monet/kitchen/cold_room/fish_check > claude_monet/kitchen/stations_report
cat claude_monet/sanitation/violations >> claude_monet/office/vika_response
mv claude_monet/hall/waiter_note claude_monet/office/guest_zone_note

git add .
git commit -m "задание 3 выполнено"

ls -lR | grep "^-" | sort -k5 -n -r | head -n 5
grep -rhi -e "наруш" -e "проверк" claude_monet 2>/dev/null | grep -vi "повторн" | sort -r | head -n 6
grep -rl "уборк" claude_monet/cleaning claude_monet/sanitation/cleaning_backup 2>/dev/null | wc -l
(head -q -n 1 claude_monet/kitchen/*/*_report claude_monet/kitchen/*/*_check; tail -q -n 1 claude_monet/kitchen/*/*_report claude_monet/kitchen/*/*_check) 2>/dev/null | grep -i -e "провер" -e "наруш" | sort
cat claude_monet/kitchen/stations_report | grep -v "Баринов" | grep -i -e "провер" -e "рыб" | sort -r | wc -w
ls -lR | grep "^-" | grep -E "[[:space:]]+2[[:space:]]+" | sort -k9
ls -lR | grep "^l" | sort -k9 -r | head -n 1

rm claude_monet/office/arrival_copy
rm inspection_link
rm claude_monet/kitchen/sanitation_access
rm claude_monet/sanitation/act_duplicate
rm claude_monet/office/guest_zone_note
rmdir claude_monet/hall
rm claude_monet/sanitation/violations
rm -r claude_monet/sanitation/cleaning_backup

git add .
git commit -m "Финалочка минус файлики"