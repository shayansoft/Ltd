function run(msg)
	blocks = load_data("../blocks.json")
	users = load_data("users.json")
	channels = load_data("channels.json")
	userid = tostring(msg.from.id)
	keyboard = {{"ایجاد متن با فونتهای مختلف و هایپر لینک"},{"ارسال کیبرد شیشه ای به کانال"},{"درج زیرنویس در عکس، فیلم، گیف و فایل"},{"تبدیل فایل صوتی به ویس و بلعکس"},{"راهنما","درباره ما","تبلیغ و تبادل"}}
	
	if msg.chat.type == "channel" then
		return
	elseif msg.chat.type == "supergroup" or msg.chat.type == "group" then
		if not msg.chat.id == admingp then
			return kickme(msg.chat.id)
		end
	end

	if msg.text == "/start" then
		start_txt = "به ربات "..bot.first_name..' خوش آمدید\n\n`در این ربات امکانات زیر را به صورت رایگان خواهید داشت:\n   - ساخت کلید شیشه ای برای کانال\n   - قرار دادن لینک روی متن، هایپر لینک\n   - نوشتن متن با فونتهای مختلف\n   - تبدیل ویس و فایل صوتی به یکدیگر\n   - و...`\n\nتوجه کنید!\nاین ربات ضد اسپم بوده و هرگونه اسپم و فلود را تشخیص میدهد و در صورتی که اسپم کنید از ربات بلاک میشوید و دیگر ربات به شما پاسخ نخواهد داد. دقت کنید که آنبلاک کردن رایگان نخواهد بود.'
		if users[userid] then
			users[userid].username = (msg.from.username or false)
			save_data("users.json", users)
			users[userid].action = 0
			save_data("users.json", users)
			return send_key(msg.from.id, start_txt, keyboard)
		else
			users[userid] = {}
			users[userid].username = (msg.from.username or false)
			users[userid].action = 0
			save_data("users.json", users)
			return send_key(msg.from.id, start_txt, keyboard)
		end
	elseif not users[userid] then
		users[userid] = {}
		users[userid].username = (msg.from.username or false)
		users[userid].action = 0
		save_data("users.json", users)
		return send_key(msg.from.id, start_txt, keyboard)
	elseif msg.text == "ارتباط با ما" or msg.text == "درباره ما" or msg.text:lower() == "about" then
		about_txt = "*LTD Robot* v"..bot_version.."\n`رباتی منحصر به فرد و رایگان برای مدیران کانال ها و افرادی که میخواهند خاص و متفاوت باشند.\nامکانات ربات:`\n   - ساخت کلید شیشه ای برای کانال\n   - قرار دادن لینک روی متن، هایپر لینک\n   - نوشتن متن با فونتهای مختلف\n   - تبدیل ویس و فایل صوتی به یکدیگر\n   - و...\n\n`محصولی از تیم قدرتمند آمبرلا.`\nبرنامه نویس: [مهندس شایان احمدی](https://telegram.me/shayan_soft)\nطراح و گرافیست: [محمد ملا قاسمی](https://telegram.me/graphi2)"
		about_key = {{{text = "کانال تیم آمبرلا" , url = "https://telegram.me/UmbrellaTeam"}},{{text = "مهندس شایان احمدی" , url = "https://telegram.me/shayan_soft"}}}
		return send_inline(msg.from.id, about_txt, about_key)
	elseif msg.text == "راهنما" or msg.text == "/help" or msg.text:lower() == "help" or msg.text == "راهنمای ربات" then
		help_admin = "_Admin Commands:_\n\n".."   *Block a user:*\n     `/block {telegram id}`\n\n".."   *Unblock a user:*\n     `/unblock {telegram id}`\n\n".."   *Block list:*\n     /blocklist\n\n".."   *Send message to all users:*\n     `/sendtoall {message}`\n\n".."   *All users list:*\n     /users"
		help_user = "ربات LTD نسخه ی "..bot_version..'\n\n- ایجاد متن با فونتهای مختلف و هایپر لینک:\n`از طریق این قابلیت میتوانید متون انگلیسی خود را به 4 حالت کلفت نویس، کج نویس، کد نویس و هایپر لینک و همچنین متون فارسی را با 2 حالت هایپر لینک و کد نویس بنویسید. به این قابلیت مارک داون نیز گفته میشود. هایپر لینک ها متونی هستند که با کلیک بر روی آنها لینکی باز خواهد شد.`\n\n- ارسال کیبرد شیشه ای به کانال:\n`از طریق این قابلیت میتوانید کیبرد شیشه ای مورد نظر خود را بسازید و با استفاده از قابلیت اینلاین، در محل مورد نظر ارسال کنید. روش کار بسیار ساده است و با توجه به توضیحی که هر کلید ارائه میکند عمل کنید. پس از ساخت کلید شیشه ای، ربات به شما پیامی حاوی یک کد ارائه میدهد که آن را باید در محل تایپ وارد کنید و منتظر بمانید تا کلیدی در بالای محل تایپ ظاهر شود، با انتخاب آن کلید کیبرد شما با کلید های شیشه ای در محل مورد نظر ارسال میگردد.`\n\n- تبدیل فایل صوتی به ویس و بلعکس:\n`با استفاده از این قابلیت میتوانید ویس را به فایل صوتی و فایل صوتی را به ویس تبدیل کنید.`\n\n- تبلیغ و تبادل:\n`در این قسمت شما میتوانید با ما در خصوص تبادل تبلیغ ارتباط برقرار کنید. تبادل و تبلیغ در این ربات انجام خواهد شد. دقت کنید که آمار کانال و ربات به طور لحظه ای و دقیق در این بخش نمایش داده خواهد شد.`\n\nطراحی و تولید در [تیم آمبرلا](https://instagram.com/umbrellateam)'
		if msg.chat.id == admingp then
			return send_msg(admingp, help_admin, true)
		else
			return send_msg(msg.from.id, help_user, true)
		end
	elseif msg.text == "تبلیغ و تبادل" then
		rdjvn = mem_num("@umbrellateam")
		i=0
		for k,v in pairs(users) do
			i=i+1
		end
		bstat = i+1395
		text = "نمایش آمار زنده:\n     زمان: "..os.date("%F - %H:%M:%S").."\n     کانال: "..rdjvn.result.."\n     ربات: "..bstat.."\n\n`برای تبادل و درج تبلیغات خود با ما در ارتباط باشید:`"
		return send_inline(msg.from.id, text, {{{text = "ارتباط با مدیر تبلیغات" , url = "https://telegram.me/shayan_soft"}},{{text = "اگر ریپورت هستید برای ارتباط اینجا کلیک کنید" , url = "https://telegram.me/shayansoftBot"}},{{text = "برای سفارش هر گونه ربات کلیک کنید" , url = "https://telegram.me/shayan_soft"}}})
	elseif msg.text:find('/sendtoall') and msg.chat.id == admingp then
		local usertarget = msg.text:input()
		if usertarget then
			send_msg(admingp, "`لطفا منتظر بمانید...`", true)
			i=1395
			for k,v in pairs(users) do
				i=i+1
				send_msg(k, usertarget, true)
			end
			return send_msg(admingp, "`پیام شما به "..i.." نفر ارسال شد`", true)
		else
			return send_msg(admingp, "*/sendtoall test*\n`/sendtoall [message]`", true)
		end
	elseif msg.text == "/users" and msg.chat.id == admingp then
		local list = ""
		i=0
		for k,v in pairs(users) do
			i=i+1
			if users[k].username then
				uz = " - @"..users[k].username
			else
				uz = ""
			end
			list = list..i.."- "..k..uz.."\n"
		end
		return send_msg(admingp, "لیست اعضا:\n\n"..list, false)
	elseif msg.text == "/blocklist" and msg.chat.id == admingp then
		local list = ""
		i=0
		for k,v in pairs(blocks) do
			if v then
				i=i+1
				list = list..i.."- "..k.."\n"
			end
		end
		return send_msg(admingp, "بلاک لیست:\n\n"..list, false)
	elseif msg.text:find('/block') and msg.chat.id == admingp then
		local usertarget = msg.text:input()
		if usertarget then
			if tonumber(usertarget) == admingp or tonumber(usertarget) == bot.id then
				return send_msg(admingp, "`نمیتوانید خودتان را بلاک کنید`", true)
			end
			if blocks[tostring(usertarget)] then
				return send_msg(admingp, "`شخص مورد نظر بلاک است`", true)
			end
			blocks[tostring(usertarget)] = true
			save_data("../blocks.json", blocks)
			send_msg(tonumber(usertarget), "`شما بلاک شدید!`", true)
			return send_msg(admingp, "`شخص مورد نظر بلاک شد`", true)
		else
			return send_msg(admingp, "`بعد از این دستور آی دی شخص مورد نظر را با درج یک فاصله وارد کنید`", true)
		end
	elseif msg.text:find('/unblock') and msg.chat.id == admingp then
		local usertarget = msg.text:input()
		if usertarget then
			if blocks[tostring(usertarget)] then
				blocks[tostring(usertarget)] = false
				save_data("../blocks.json", blocks)
				send_msg(tonumber(usertarget), "`شما آنبلاک شدید!`", true)
				return send_msg(admingp, "`شخص مورد نظر آنبلاک شد`", true)
			end
			return send_msg(admingp, "`شخص مورد نظر بلاک نیست`", true)
		else
			return send_msg(admingp, "`بعد از این دستور آی دی شخص مورد نظر را با درج یک فاصله وارد کنید`", true)
		end
	end
	
	if msg.chat.id == admingp then
		return
	end
	
	if msg.text == "لغو" or msg.text == "منو" or msg.text:lower() == "/update" then
		users[userid].action = 0
		save_data("users.json", users)
		return send_key(msg.from.id, "`کلید مورد نظر را انتخاب نمایید:`", keyboard)
	elseif msg.text == "ایجاد متن با فونتهای مختلف و هایپر لینک" then
		users[userid].action = 1
		save_data("users.json", users)
		return send_key(msg.from.id, "از این طریق میتوانید متون خود را با فونتهای مختلف (قابلیت مارک داون) و قرار دادن لینک روی متن (هایپر لینک) ایجاد کنید.\n\n`برای کلفت نویسی، متن مورد نظر را بین 2 عدد * قرار دهید. دقت کنید این قابلیت مربوط به حروف انگلیسی است. مثال:\n*`Umbrella`* =` *Umbrella*\n\n`برای کج نویسی، متن مورد نظر را بین 2 عدد _ قرار دهید. دقت کنید این قابلیت مربوط به حروف انگلیسی است. مثال:\n_`Umbrella`_ = `_Umbrella_\n\n*برای ماشین نویسی یا نوشتن با حالت کدینگ، متن مورد نظر را بین 2 عدد ` قرار دهید. از این حالت میتوانید در حروف فارسی و انگلیسی بهره ببرید. مثال:\n`*Umbrella*`=*  `Umbrella`\n\n`برای قراردادن لینک روی متن و هایپر لینک، متن مورد نظر را بین [] قرار دهید و لینک مورد نظر را نیز بین () بگذارید. مثال:\n[Umbrella](telegram.me/umbrellateam)` = [Umbrella](telegram.me/umbrellateam)\n\nمتن خود را طبق فرمول گفته شده ارسال کنید:", {{"لغو"}}, true)
	elseif msg.text == "ارسال کیبرد شیشه ای به کانال" then
		users[userid].action = 2
		save_data("users.json", users)
		return send_key(msg.from.id, '`متنی را حداکثر تا 4000 کاراکتر وارد کنید. قابلت مارک داون که در بخش "ایجاد متن با فونتهای مختلف و هایپر لینک" توضیح داده شد نیز فعال است و میتوانید از فرمول های آن نیز استفاده کنید. دقت کنید که کیلیدهای شیشه ای زیر این متن نمایش داده میشوند پس این متن اصلی میباشد.`', {{"لغو"},{"مثال کیبرد اینلاین"}}, true)
	elseif msg.text == "تبدیل فایل صوتی به ویس و بلعکس" then
		users[userid].action = 3
		save_data("users.json", users)
		return send_key(msg.from.id, "`فایل صوتی (Audio) یا ویس را فوروارد یا ارسال کنید. حداکثر حجم مجاز 50 مگابایت است.`", {{"لغو"}}, true)
	elseif msg.text == "درج زیرنویس در عکس، فیلم، گیف و فایل" then
		users[userid].action = 4
		save_data("users.json", users)
		return send_key(msg.from.id, "`يک عکس، ويدئو، گيف یا فايل فوروارد یا ارسال نماييد. حداکثر حجم مجاز 50 مگابايت ميباشد.`", {{"لغو"}}, true)
	elseif msg.text == "مثال کیبرد اینلاین" then
		return send_inline(msg.from.id, "`تیتر کیبرد اینلاین با قابلیت استفاده از قابلیت مارک داون و هایپر لینک.`", {{{text = "وبسایت تیم آمبرلا" , url = "http://Umbrella.shayan-soft.ir"}},{{text = "کانال تیم آمبرلا" , url = "https://telegram.me/UmbrellaTeam"}}})
	end
	
	if users[userid].action == 0 then
		return send_key(msg.from.id, "`ورودی صحیح نیست، یک گزینه دیگر را انتخاب کنید.`", keyboard)
	elseif users[userid].action == 1 then
		users[userid].action = 0
		save_data("users.json", users)
		send_msg(msg.from.id, msg.text, true)
		return send_key(msg.from.id, "اگر فرمول را درست وارد کرده باشید و از علامت ها ` و _ و * و ( و ) و [ و ] به صورت تکی و خارج از چهار چوب استفاده نکرده باشید، متن شم در زیر ساخته و ارسال خواهد شد.", keyboard, false, true)
	elseif users[userid].action == 3 then		
		if msg.audio then
			send_voice(msg.from.id, msg.audio.file_id)
		elseif msg.voice then
			send_audio(msg.from.id, msg.voice.file_id)
		else
			return send_msg(msg.from.id, "`فقط قادر به ارسال فایل موسیقی یا ویس جهت تبدیل به دیگری هستید.`", true)
		end
		users[userid].action = 0
		save_data("users.json", users)
		return send_key(msg.from.id, "`کلید مورد نظر را انتخاب نمایید:`", keyboard)
	elseif users[userid].action == 2 then
		if string.len(msg.text) > 4000 then
			return send_key(msg.from.id, "`متن وارد شده بیش از 4000 کاراکتر میباشد، متن را اصلاح نمایید`", {{"لغو"}}, true)
		end
		users[userid].titr = msg.text
		users[userid].action = 20
		save_data("users.json", users)
		return send_key(msg.from.id, "`تعداد کلیدهای کیبرد شیشه ای را وارد نمایید. حداکثر 20 عدد مجاز است.`", {{"لغو"}}, true)
	elseif users[userid].action == 20 then
		if not string.match(msg.text, '^%d+$') then
			return send_msg(msg.from.id, "`عددی بین 1 تا 20 وارد کنید.`", true)
		end
		if tonumber(msg.text) > 20 then
			return send_msg(msg.from.id, "`تعداد کلیدهای مجاز حداکثر 20 عدد میباشد، اصلاح کنید.`", true)
		end
		if tonumber(msg.text) < 1 then
			return send_msg(msg.from.id, "`حداقل کلیدها باید 1 عدد باشد.`", true)
		end
		users[userid].action = 21
		users[userid].tab = tonumber(msg.text)
		users[userid].tables = ""
		save_data("users.json", users)
		return send_key(msg.from.id, "`متن کلید `"..msg.text.."` را تا حداکثر 50 کاراکتر وارد نمایید.`", {{"لغو"}}, true)
	elseif users[userid].action == 21 then
		if string.len(msg.text) > 50 then
			return send_msg(msg.from.id, "`متن وارد شده بیش از 50 کاراکتر میباشد، متن را اصلاح نمایید`", true)
		end
		users[userid].action = 22
		users[userid].tabtxt = msg.text
		save_data("users.json", users)
		return send_msg(msg.from.id, "`لینکی که میخواهید این کلید نماینده ی آن باشد را وارد کنید\nمثال: https://telegram.me/umbrellateam`", true)
	elseif users[userid].action == 22 then
		if users[userid].tables == "" then
			tabtab = ""
		else
			tabtab = users[userid].tables..","
		end
		users[userid].tables = tabtab..'[{"text":"'..users[userid].tabtxt..'","url":"'..msg.text..'"}]'
		if users[userid].tab == 1 then
			hashid = userid..os.date("%F%H%M%S")
			channels[tostring(hashid)] = {}
			channels[tostring(hashid)].title = users[userid].titr
			channels[tostring(hashid)].tables = users[userid].tables
			save_data("channels.json", channels)
			users[userid].action = 0
			save_data("users.json", users)
			send_msg(msg.from.id, "`@LTDbot "..hashid.."`", true)
			return send_key(msg.from.id, "`کیبرد شیشه ای ساخته شد، متن زیر را در محل تایپ وارد نمایید و منتظر بمانید تا کلید ارسال ظاهر شود، با کلیک روی کلید کیبرد شما به محل مورد نظر ارسال میگردد. دقت کنید این کد را به دفعات مختلف میتوانید استفاده کنید و اطلاعات آن در دیتا بیس میماند.`", keyboard)
		else
			users[userid].tab = users[userid].tab-1
			users[userid].action = 21
			save_data("users.json", users)
			return send_key(msg.from.id, "`متن کلید `"..users[userid].tab.."` را تا حداکثر 50 کاراکتر وارد نمایید.`", {{"لغو"}}, true)
		end
	elseif users[userid].action == 4 then
		if msg.document then
			users[userid].file_type = "document"
			users[userid].file_id = msg.document.file_id
		elseif msg.video then
			users[userid].file_type = "video"
			users[userid].file_id = msg.video.file_id
		elseif msg.photo then
			i = #msg.photo
			users[userid].file_type = "photo"
			users[userid].file_id = msg.photo[i].file_id
		else
			return send_msg(msg.from.id, "`فقط قادر به ارسال عکس، ويدئو، گيف و فايل ميباشيد. حداکثر حجم مجاز 50 مگابايت ميباشد.`", true)
		end
		users[userid].action = 40
		save_data("users.json", users)
		return send_key(msg.from.id, "`يکي از آيتم ها را انتخاب نماييد`", {{"لغو"},{"وارد کردن زيرنويس"},{"ارسال بدون زيرنويس"}}, true)
	elseif users[userid].action == 40 then
		if msg.text == "وارد کردن زيرنويس" then
			users[userid].action = 41
			save_data("users.json", users)
			return send_key(msg.from.id, "`متن مورد نظر را وارد کنيد، دقت کنيد که متن وارد شده کمتر از 300 کاراکتر باشد و در آن از فرمولهاي مارک داون استفده نشود.`", {{"لغو"}}, true)
		elseif msg.text == "ارسال بدون زيرنويس" then
			if users[userid].file_type == "document" then
				send_doc(msg.from.id, users[userid].file_id, false)
			elseif users[userid].file_type == "video" then
				send_video(msg.from.id, users[userid].file_id, false)
			elseif users[userid].file_type == "photo" then
				send_photo(msg.from.id, users[userid].file_id, false)
			end
		else
			return send_msg(msg.from.id, "`ورودي صحيح نيست.`", true)
		end
		users[userid].action = 0
		save_data("users.json", users)
		return send_key(msg.from.id, "`عمليات مورد نظر انجام شد.`", keyboard)
	elseif users[userid].action == 41 then
		if not msg.text then
			return send_msg(msg.from.id, "`فقط قادر به ارسال متن میباشید.`", true)
		end
		if string.len(msg.text) > 300 then
			return send_msg(msg.from.id, "`متن وارد شده بیش از 300 کاراکتر میباشد، متن را اصلاح نمایید`", true)
		end
		if users[userid].file_type == "document" then
			send_doc(msg.from.id, users[userid].file_id, msg.text)
		elseif users[userid].file_type == "video" then
			send_video(msg.from.id, users[userid].file_id, msg.text)
		elseif users[userid].file_type == "photo" then
			send_photo(msg.from.id, users[userid].file_id, msg.text)
		end
		users[userid].action = 0
		save_data("users.json", users)
		return send_key(msg.from.id, "`عملیات مورد نظر انجام شد.`", keyboard)
	end
end

function inline(msg)
	tab1 = '{"type":"article","parse_mode":"Markdown","disable_web_page_preview":true,"id":'
	thumb = "http://umbrella.shayan-soft.ir/inline_icons/"
	if msg.query == "" or msg.query == nil then
		tab_inline = tab1..'"1","title":"کد را وارد کنید","description":"کد کیبردی که قبلا ساخته اید را وارد کنید یا همینک آن را بسازید","message_text":"جهت ساخت کیبرد به پی وی ربات مراجعه کنید\n@LTDbot","thumb_url":"'..thumb..'ltd.png"}'
	else
		channels = load_data("channels.json")
		if channels[tostring(msg.query)] then
			tabless = channels[tostring(msg.query)].tables:gsub("\\","")
			tab_inline = tab1..'"2","title":"ارسال کیبرد","description":"جهت ارسال کیبرد اینجا کلیک کنید","message_text":"'..channels[tostring(msg.query)].title..'","thumb_url":"'..thumb..'keyk_ok.png","reply_markup":{"inline_keyboard":['..tabless..']}}'
		else
			tab_inline = tab1..'"3","title":"کد صحیح نیست","description":"کد کیبرد وارد شده صحیح نیست، برای ساخت کلیک کنید","message_text":"جهت ساخت کیبرد به پی وی ربات مراجعه کنید\n@LTDbot","thumb_url":"'..thumb..'ltder.png"}'
		end
	end
	return send_req(send_api.."/answerInlineQuery?inline_query_id="..msg.id.."&is_personal=true&cache_time=1&results="..url.escape('['..tab_inline..']'))
end

return {launch = run , inline = inline}