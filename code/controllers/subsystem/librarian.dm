SUBSYSTEM_DEF(librarian)
	name = "Librarian"
	init_order = INIT_ORDER_PATH
	flags = SS_NO_FIRE
	var/list/books = list()

/datum/controller/subsystem/librarian/proc/get_book(input)
	if(!input)
		return list()
	if(books.Find(input))
		return books[input]
	else
		books[input] = file2book(input)
		return books[input]
	return list()

/proc/file2book(filename)
	if(!filename)
		return list()
	var/json_file = file("strings/books/[filename]")
	testing("filebegin")
	if(fexists(json_file))
		testing("file1")
		var/list/configuration = json_decode(file2text(json_file))
		var/list/contents = configuration["Contents"]
		if(isnull(contents))
			testing("file2")
			return list()
		return contents
	testing("file4")
	return list()

/datum/controller/subsystem/librarian/proc/playerbook2file(input, book_title = "Unknown", author = "Unknown", author_ckey = "Unknown", icon = "basic_book")
	if(!input)
		return "There is no text in the book!"
	if(fexists("data/player_generated_books/[url_encode(book_title)].json"))
		return "there is already a book by this title!"
	if(!(istext(input) && istext(book_title) && istext(author) && istext(author_ckey) && istext(icon)))
		return "This book is incorrectly formatted!"

	testing("playerbook2file1").
	var/list/contents = list("book_title" = "[book_title]", "author" = "[author]", "author_ckey" = "[author_ckey]", "icon" = "[icon]",  "text" = "[input]")
	//url_encode should escape all the characters that do not belong in a file name. If not, god help us
	var/file_name = "data/player_generated_books/[url_encode(book_title)].json"
	text2file(json_encode(contents), file_name)

	if(fexists("data/player_generated_books/_book_titles.json"))
		testing("playerbook2file2")
		var/list/_book_titles_contents = json_decode(file2text("data/player_generated_books/_book_titles.json"))
		_book_titles_contents += "[url_encode(book_title)]"
		fdel("data/player_generated_books/_book_titles.json")
		text2file(json_encode(_book_titles_contents), "data/player_generated_books/_book_titles.json")
		message_admins("Book [book_title] has been saved to the player book database by [author_ckey]([author])")
		return "You have a feeling the newly written book will remain in the archive for a very long time..."
	else
		message_admins("!!! _book_titles.json no longer exists, previous book title list has been lost. making a new one without old books... !!!")
		text2file(json_encode(list(book_title)), "data/player_generated_books/_book_titles.json")
		return "_book_titles.json no longer exists, yell at your server host that some books have been lost!"

/datum/controller/subsystem/librarian/proc/file2playerbook(filename)
	if(!filename)
		return list()
	var/json_file = file("data/player_generated_books/[filename].json")
	testing("playerfilebegin")
	if(fexists(json_file))
		testing("playerfile1")
		var/list/contents = json_decode(file2text(json_file))
		if(isnull(contents))
			testing("playerfile2")
			return list()
		return contents
	testing("playerfile4")
	return list()

/datum/controller/subsystem/librarian/proc/del_player_book(book_title)
	if(!book_title)
		return FALSE
	var/json_file = file("data/player_generated_books/[book_title].json")
	if(!fexists(json_file))
		return FALSE
	if(fexists("data/player_generated_books/_book_titles.json"))
		testing("delplayerbook")
		fdel(json_file)
		var/list/_book_titles_contents = json_decode(file2text("data/player_generated_books/_book_titles.json"))
		_book_titles_contents -= "[book_title]"
		fdel("data/player_generated_books/_book_titles.json")
		text2file(json_encode(_book_titles_contents), "data/player_generated_books/_book_titles.json")
		return TRUE
	else
		message_admins("!!! _book_titles.json no longer exists, previous book title list has been lost. !!!")
		return FALSE


/datum/controller/subsystem/librarian/proc/pull_player_book_titles()
	testing("pullplayerbook")
	if(fexists(file("data/player_generated_books/_book_titles.json")))
		var/json_file = file("data/player_generated_books/_book_titles.json")
		var/json_list = json_decode(file2text(json_file))
		return json_list
	else
		message_admins("!!! _book_titles.json no longer exists, previous book title list has been lost. !!!")
