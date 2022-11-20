#!/bin/bash
create (){
echo -n -e "\nEnter the filename which you want to create = "
read db
touch $db
echo -e "\n*****File created****\n"
}
insert(){
if [ -z $db ];then
echo -e "\n\n!!!!!Database doesnt exist. Create a new database!!!!!\n"
else
echo -n -e "\nEnter the number of records to be added = "
read no
while [ $no -gt 0 ]
do
echo -e -n "\nEnter roll no: "
read rno
srno=`grep "^$rno" "$db"`
if [ -z $srno ]
then
echo -n -e "Enter Name: "
read name
echo -n "Enter Address : "
read address
record=$rno":"$name":"address
echo $record >> "$db"
no=$(($no-1))
else
echo -e "\n\n!!!!!!Record already exists!!!!!!\n\n"
fi
done
echo -e "\n\n"
fi
}
search(){
echo " Enter roll no: "
read rno
record=`grep "^$rno" "$db"`
if [ $? -ne 0 ]; then
echo "Record doesnt exist. "
else
echo "Record found"
echo $record
fi
}
modify(){
echo " Enter roll no to modify: "
read rno
grep "^$rno" $db > temp1.txt
grep -v "^$rno" $db > temp2.txt
mv temp2.txt $db
if [ $? -ne 0 ]; then
echo "Record doesnt exist. "
else
name=`cut -d ":" -f2 "temp1.txt"`
address=`cut -d ":" -f3 "temp1.txt"`
echo $name
echo $address
echo "Enter the value you want to modify"
MENU=" Values
1)Name
2)Address
"
echo "$MENU"
echo "Enter your choice"
read n1
case $n1 in
1)
echo "Enter the new name"
read name
;;
2)
echo "Enter the new address"
read address
;;
*)
echo "Enter a vaid choice"
;;
esac
record=$rno":"$name":"$address
echo $record >> "$db"
fi
}
delete(){
echo " Enter roll no: "
read rno
record=`grep "^$rno" "$db"`
if [ $? -ne 0 ]; then
echo "Record doesnt exist. "
else
echo "Record found"
echo $record
record=`grep -v "^$rno" "$db" > tmp.txt`
mv tmp.txt $db
echo "Record deleted."
fi
}
display(){
echo " Complete database..."
cat $db
}
MENU1="****Menu****
1)Create
2) Insert
3)Search
4)Modify
5)Delete
6)Display
7)Exit
"
while true
do
echo -n "$MENU1"
echo -n "Enter the choice: "
read n
case $n in
1) create
;;
2)insert
;;
3) search
;;
4) modify
;;
5) delete
;;
6) display
;;
7) exit
;;
esac
done
