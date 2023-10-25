extends Gift

func _ready() -> void:
    cmd_no_permission.connect(no_permission)
    chat_message.connect(on_chat)
    event.connect(on_event)
    
    var authfile := FileAccess.open("./auth.txt", FileAccess.READ)
    client_id = authfile.get_line()
    client_secret = authfile.get_line()
    var initial_channel = authfile.get_line()
    
    await(authenticate(client_id, client_secret))
    var success = await(connect_to_irc())
    if (success):
        request_caps()
        join_channel(initial_channel)
    await(connect_to_eventsub())
    
    add_command("helloworld", hello_world)
    add_command("greetme", greet_me)

func on_event(type : String, data : Dictionary) -> void:
    match(type):
        "channel.follow":
            print("%s followed your channel!" % data["user_name"])

func on_chat(data : SenderData, msg : String) -> void:
    %ChatContainer.put_chat(data, msg)

# Check the CommandInfo class for the available info of the cmd_info.
func command_test(cmd_info : CommandInfo) -> void:
    print("A")

func hello_world(cmd_info : CommandInfo) -> void:
    chat("HELLO WORLD!")

func streamer_only(cmd_info : CommandInfo) -> void:
    chat("Streamer command executed")

func no_permission(cmd_info : CommandInfo) -> void:
    chat("NO PERMISSION!")

func greet(cmd_info : CommandInfo, arg_ary : PackedStringArray) -> void:
    chat("Greetings, " + arg_ary[0])

func greet_me(cmd_info : CommandInfo) -> void:
    chat("Greetings, " + cmd_info.sender_data.tags["display-name"] + "!")

func list(cmd_info : CommandInfo, arg_ary : PackedStringArray) -> void:
    var msg = ""
    for i in arg_ary.size() - 1:
        msg += arg_ary[i]
        msg += ", "
    msg += arg_ary[arg_ary.size() - 1]
    chat(msg)
