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
	if(file("data/player_generated_books/[book_title]"))
		return "there is already a book by this title!"
	if(!(istext(input) && istext(book_title) && istext(author) && istext(author_ckey) && istext(icon)))
		return "This book is incorrectly formatted!"

	var/sanitize_list = list("\n"="", "\t"="", "<"="", ">"="")
	testing("playerbook2file1")
	var/list/contents = list("book_title" = "[sanitize_hear_message(book_title)]", "author" = "[sanitize_simple(author, sanitize_list)]", "author_ckey" = "[sanitize_simple(author_ckey, sanitize_list)]", "icon" = "[icon]",  "text" = "[sanitize_simple(input, sanitize_list)]")
	var/file_name = "data/player_generated_books/[book_title].json"
	WRITE_FILE(file_name, json_encode(contents))

	testing("playerbook2file2")
	if(fexists(file("data/player_generated_books/_book_titles.json")))
		var/list/_book_titles_contents = json_decode(file2text("data/player_generated_books/_book_titles.json"))
		_book_titles_contents = list(_book_titles_contents, "[sanitize_hear_message(book_title)]\n")
		WRITE_FILE("data/player_generated_books/_book_titles.json", json_encode(_book_titles_contents))

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

	testing("delplayerbook")
	fdel(json_file)
	return TRUE

/datum/controller/subsystem/librarian/proc/who_made_player_book(book_title = "test")
	if(!book_title)
		return FALSE
	var/json_file = file("data/player_generated_books/[book_title].json")
	if(!fexists(json_file))
		return FALSE

	testing("whomadeplayerbook")
	var/json_list = json_decode(json_file)
	var/ckey = "[json_list["author_ckey"]] as [json_list["author"]]"
	return ckey

/datum/controller/subsystem/librarian/proc/pull_player_book_titles()
	testing("pullplayerbook")
	if(fexists(file("data/player_generated_books/_book_titles.json")))
		var/json_file = file("data/player_generated_books/_book_titles.json")
		var/json_list = json_decode(file2text(json_file))
		return json_list
