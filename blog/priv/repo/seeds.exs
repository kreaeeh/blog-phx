# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Blog.Repo
alias Blog.Accounts.User
alias Blog.Posts.Post
alias Blog.Comments.Comment


# seed users
Repo.insert! %User{
  fullname: "Jhon Smith",
  email: "jhon.misterlab@getnada.com",
  hashed_password: "$2b$12$LqRkMKsGB2botuNJ96YdaO8XvSrW5UeMo4zIKUM92GCcscSoMB"
}

Repo.insert! %User{
  fullname: "Charlie D. Shaw",
  email: "char.misterlab@getnada.com",
  hashed_password: "$2b$12$LqRkMKsGB2botuNJ96YdaO8XvSrW5UeMo4zIKUM92GCcscSoMB"
}
Repo.insert! %User{
  fullname: "Betty W. Vaughn",
  email: "betty.misterlab@getnada.com",
  hashed_password: "$2b$12$LqRkMKsGB2botuNJ96YdaO8XvSrW5UeMo4zIKUM92GCcscSoMB"
}

#seed posts
Repo.insert! %Post{
  title: "Photography, Shooting Styles, Phone Shots",
  body: "
Dummy Image With Link to Itself
Why our world would end if photography courses disappeared. Will graphic artists ever rule the world? 16 great articles about photo stocks. How not knowing photo stocks makes you a rookie. Why you shouldn't eat photography idea in bed. Why our world would end if photography services disappeared. 5 facts about photography awards that'll keep you up at night. What experts are saying about graphic organizers. Will spring pictures ever rule the world? 20 least favorite photo awards.

The evolution of graphic organizers. What the world would be like if graphic organizers didn't exist. How photo stocks can help you live a better life. The only family portrait resources you will ever need. Why photography lights will make you question everything. Why photography lighting tips will make you question everything. Unbelievable photography tutorial success stories. The 9 best photo stock twitter feeds to follow. The 6 biggest wedding picture blunders. Why your graphic organizer never works out the way you plan.",
  user_id: 3
}

Repo.insert! %Post{
  title: "Just testing ",
  body: "
oh yeah it works
Why our world would end if photography courses disappeared. Will graphic artists ever rule the world? 16 great articles about photo stocks. How not knowing photo stocks makes you a rookie. Why you shouldn't eat photography idea in bed. Why our world would end if photography services disappeared. 5 facts about photography awards that'll keep you up at night. What experts are saying about graphic organizers. Will spring pictures ever rule the world? 20 least favorite photo awards.

The evolution of graphic organizers. What the world would be like if graphic organizers didn't exist. How photo stocks can help you live a better life. The only family portrait resources you will ever need. Why photography lights will make you question everything. Why photography lighting tips will make you question everything. Unbelievable photography tutorial success stories. The 9 best photo stock twitter feeds to follow. The 6 biggest wedding picture blunders. Why your graphic organizer never works out the way you plan.",
  user_id: 3
}
Repo.insert! %Post{
  title: "Heath, Fitness, Weight Loss, Health Care",
  body: "5 things about fitness equipment your kids don't want you to know. 15 things you don't want to hear about travel vaccines. Home health care products in 17 easy steps. The 11 worst nutrition label makers in history. 15 least favorite nutrition facts. 15 movies with unbelievable scenes about health care solutions. Why home health care products will change your life. 10 ways vaccination schedules can make you rich. The only online nutrition course resources you will ever need. How twitter can teach you about healthy eating facts.",
  user_id: 2
}
Repo.insert! %Post{
  title: "Technology, Devices, Science, Application",
  body: "Why science articles are killing you. Why geek ideas are killing you. 13 great articles about dollar general applications. 14 insane (but true) things about latest electronic gadgets. Why your best store never works out the way you plan. The 19 best amazing gadget twitter feeds to follow. The 12 worst dollar general applications in history. Why accessories are afraid of the truth. Why you shouldn't eat open source software in bed. Why computer support specialists are afraid of the truth.",
  user_id: 1
}


Repo.insert! %Comment{
  user_id: 1,
  post_id: 1,
  content: "I see you have something to talk about. Well, I have something to shout about. Infact something to sing about. But I'll just keep quiet and let you carry on.",
  liked_count: 7,
  dislike_count: 43,
  smile_count: 3
}

Repo.insert! %Comment{
  user_id: 2,
  post_id: 1,
  content: "I can drive 10 miles, walk 50 feet. Turn around and before I know it, I'd be back home. Or would I? I'm not sure but that's just how it is.",
  liked_count: 3,
  dislike_count: 3,
  smile_count: 12
}

Repo.insert! %Comment{
  user_id: 3,
  post_id: 2,
  content: "Look! In the sky. It's a bird, it's a plane. Or is it a hellicopter? No actually I think it is a bird. Or maybe I'm just seeing things. Who knows... After 10 shots of Whiskey things start to get a bit strange.",
  liked_count: 3,
  dislike_count: 3,
  smile_count: 3
}


Repo.insert! %Comment{
  user_id: 1,
  post_id: 2,
  content: "From this day on I shall be known as Bob. For Bob is a good name and I am good. But if you want you can just call me Sally.",
  liked_count: 3,
  dislike_count: 3,
  smile_count: 3
}

Repo.insert! %Comment{
  user_id: 2,
  post_id: 2,
  content: "Sometimes I wonder if I really can. But then I think to myself, maybe I can't. But if I could, that would be good. Maybe it's all a lie?",
  liked_count: 3,
  dislike_count: 3,
  smile_count: 3
}

Repo.insert! %Comment{
  user_id: 3,
  post_id: 3,
  content: "It's gonna take a lot to take me away from you There's nothing that a hundred men or more could ever do I bless the rains down in Africa Gonna take some time to do the things we never have. ",
  liked_count: 32,
  dislike_count: 3,
  smile_count: 31
}
Repo.insert! %Comment{
  user_id: 1,
  post_id: 3,
  content: "And everything is going to the beat And everything is going to the beat And everything is going...",
  liked_count: 111,
  dislike_count: 3,
  smile_count: 32
}



