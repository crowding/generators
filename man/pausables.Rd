% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/syntax.R
\name{pausables}
\alias{pausables}
\title{Pausable functions.}
\usage{
pausables(envir = caller(), packages = base::.packages())
}
\arguments{
\item{envir}{The environment to search (defaulting to the calling
environment).}

\item{packages}{Which packages to search; defaults to currently
loaded packages. You can scan all packages with
\code{pausables(packages=base::.packages(all.available=TRUE))}}
}
\value{
A list of expressions (either names or \code{:::} calls)
}
\description{
\code{\link{async}} and \code{\link{gen}} rely on "pausable" workalikes for R functions
like \code{if}, \code{while}, and so on. \code{pausables()} scans for and returns
a list of all pausable functions visible in the present environment
and in attached packages.
}
\details{
It is possible for a third party package to define pausable
functions. To do this:
\enumerate{
\item Define and export a function \code{yourname} and an ordinary R implementation
(the pausable version is only used when there is an \code{await} or
\code{yield} in the arguments.)
\item Also define a function \code{yourname_cps} in your package namespace. (It
does not need to be exported.) \code{yourname_cps} should have the pausable
(callback based)
implementation.
}

The API for pausable functions is not yet fixed, but it is described
in source file \code{cps.r} along with implementataions for core R functions.
}
