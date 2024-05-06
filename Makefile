
all:run80

run80:
	sudo bundle exec jekyll serve -P 80 -H 0.0.0.0


run:
	bundle exec jekyll serve
.PHONY: run  clean test run80

update:
	bundle update
clean:
	rm -rf _site
#gem install jekyll-theme-sidey
#修改_config.yml 里面的主题为 jeckyll-theme-sidey
#然后update 一下 然后run 

env:
	if [ -f maketitle.sh ]; then \
		. maketitle.sh ; \
	fi

test:
	bundle exec jekyll serve --trace
