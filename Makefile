include .env
export

all: book

book: epub html pdf

clean:
	rm -r ${BUILD}

epub: ${BUILD}/epub/${BOOKNAME}.epub

html: ${BUILD}/html/${BOOKNAME}.html

pdf: ${BUILD}/pdf/${BOOKNAME}.pdf

${BUILD}/epub/${BOOKNAME}.epub: ${TITLE} ${CHAPTERS}
	mkdir -p ${BUILD}/epub
	pandoc ${TOC} -f markdown+smart --epub-metadata=${METADATA} --epub-cover-image=${COVER_IMAGE} -o ${TITLE}.epub ${CHAPTERS}

${BUILD}/html/${BOOKNAME}.html: ${CHAPTERS}
	mkdir -p ${BUILD}/html
	pandoc ${TOC} --standalone --to=html5 -o $@ $^

${BUILD}/pdf/${BOOKNAME}.pdf: ${TITLE} ${CHAPTERS}
	mkdir -p ${BUILD}/pdf
	pandoc ${TOC} --latex-engine=xelatex -V documentclass=${LATEX_CLASS} -o ${TITLE}.pdf ${CHAPTERS}

.PHONY: all book clean epub html pdf
