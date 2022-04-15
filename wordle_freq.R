dict <- readLines("wordle_dictionary.txt")

dict <- gsub("\"", "", dict)
dict <- unlist(strsplit(dict, ","))

# the first 2309 words are possible solutions, the rest are accepted guesses.
choices <- dict[1:2309]

# insert one ocurence of missing letters to make life simpler
a <- c("x", as.vector(sapply(choices, substr, 1, 1)))
b <- as.vector(sapply(choices, substr, 2, 2))
c <- as.vector(sapply(choices, substr, 3, 3))
d <- c("q", as.vector(sapply(choices, substr, 4, 4)))
e <- c("q", "j", "v", as.vector(sapply(choices, substr, 5, 5)))

tab <- cbind(table(a),
             table(b),
             table(c),
             table(d),
             table(e))

colnames(tab) <- c("First", "Second", "Third", "Fourth", "Fifth")

tab.m <- melt(tab)
tab.m$Var2 <- factor(tab.m$Var2)
colnames(tab.m) <- c("letter", "position", "frequency")

ggplot(tab.m, aes(x=letter, y = frequency)) +
  geom_bar(stat = "identity", color = "orange", width=0.5) +
  facet_wrap(~position, ncol = 1) +
  theme_bw() +
  theme(axis.title = element_text(face="bold"))

