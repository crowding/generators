% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gen.R
\name{gen}
\alias{gen}
\alias{yield}
\title{Create an iterator using sequential code.}
\usage{
gen(expr, ..., split_pipes = FALSE, trace = trace_)

yield(expr)
}
\arguments{
\item{expr}{An expression, to be turned into an iterator.}

\item{...}{Undocumented.}

\item{split_pipes}{Silently rewrite expressions where "yield"
appears in chained calls. See \link{async}.}

\item{trace}{Optional tracing function for debugging. See \link{async}.}
}
\description{
\code{gen({...})} with an expression written in its argument, creates a
generator, which acts like a block of code whose execution can
pause and resume. From the "inside," a generator looks like you are
writing sequential code with loops, branches and such, writing
values to the outside world by calling \code{yield()}. From the "outside,"
a generator behaves like an iterator over an indefinite collection.
}
\details{
When \code{nextElem} is called on a generator, the generator executes
its given expression until it reaches a call to \verb{yield(...).}
\code{nextElem} returns argument to \code{yield} is returne, and the
generator's execution state is preserved. The generator will resume
on the next call to \code{nextElem()}.

The generator expression is evaluated in a local environment.

Generators are not based on forking or parallel OS processes; they
run in the same thread as their caller. The control flow in a
generator is interleaved with that of the R code which queries it.

A generator expression can use any R functions, but a call to
\code{yield} may only appear in some positions. This package has several
built-in (pausables), equivalents to R's base control flow
functions, such as \code{if}, \code{while}, \code{tryCatch}, \verb{<-}, \code{{}}, \code{||} and
so on.  A call to \code{yield} may only appear in an argument of one of
these pausable functions. So this random walk generator:\if{html}{\out{<div class="r">}}\preformatted{rwalk <- gen(\{x <- 0; repeat \{x <- yield(x + rnorm(1))\}\})
}\if{html}{\out{</div>}}

is legal, because \code{yield} appears within arguments to \code{{}},
\code{repeat}, and \verb{<-}, for which this package has pausable
definitions. However, this:\if{html}{\out{<div class="r">}}\preformatted{rwalk <- gen(\{x <- rnorm(1); repeat \{x <- rnorm(1) + yield(x)\}\})
}\if{html}{\out{</div>}}

is not legal, because \code{yield} appears in an argument to \code{+}, which
does not have a pausable definition.
}
