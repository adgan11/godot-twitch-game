extends Control

var tier_one_list = []
var tier_two_list = []
var tier_three_list = []
var total_list = []

func _ready():
    $ChatContainer.message_sent.connect(self.fetch_message)
    
func fetch_message():
    print("called............")
    for i in $ChatContainer.get_child(0).get_child(0).get_child(0).get_children():
        total_list.append($ChatContainer.get_child(0).get_child(0).get_child(0).get_children()[$ChatContainer.get_child(0).get_child(0).get_child(0).get_children().find(i)].get_child(0).text)
    for j in total_list:
        if "t1" in j.split(":")[3]:
            print("ye tier 1 mei hai")
        elif "t2" in j.split(":")[3]:
            print("ye tier 2 mei hai")
        elif "t3" in j.split(":")[3]:
            print("ye tier 3 mei hai")
