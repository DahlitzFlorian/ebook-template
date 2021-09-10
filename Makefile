include .env
export

all: book

book: epub html pdf

clean:
	rm -r ${BUILD}

epub: ${BUILD}/epub/${BOOKNAME}.epub

html: ${BUILD}/html/${BOOKNAME}.html

pdf: ${BUILD}/pdf/${BOOKNAME}.pdf

${BUILD}/epub/${BOOKNAME}.epub:
	mkdir -p ${BUILD}/epub
	pandoc ${TOC} --metadata title="${TITLE}" --epub-metadata=${METADATA} --epub-cover-image=${COVER_IMAGE} -o $@ ${CHAPTERS}

${BUILD}/html/${BOOKNAME}.html:
	mkdir -p ${BUILD}/html
	pandoc ${TOC} --standalone --to=html5 -o $@ $^

${BUILD}/pdf/${BOOKNAME}.pdf:
	mkdir -p ${BUILD}/pdf
	pandoc ${TOC} --pdf-engine=xelatex -V documentclass=${LATEX_CLASS} -o $@ ${CHAPTERS}

.PHONY: all book clean epub html pdf
