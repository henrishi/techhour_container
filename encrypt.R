# Athey Lab Tech Hour Demo 2019-02-19
# Henry Shi (zshi2@stanford.edu)

# encryption is based on the Sodium library
library('sodium')

# producing hashed version of key and nonce
# these are used in the actual encryption
key <- 'key'
nonce <- 'nonce'
keyhash <- sha256(charToRaw(as.character(key)))
noncehash <- sha256(charToRaw(as.character(nonce)))[1:24]

# encrypt function for a single string
encryptSingle <- function(string){
	if(string == '' || is.na(string)){ 
		# empty string encrypt to empty
		return('')
	} else {
		# turning raw into characters
		encrypted <- data_encrypt(charToRaw(string), keyhash, noncehash)
		return(paste0(as.character(encrypted), collapse = ''))
	}
}

# wrapper to handle vectors, this is what t
# he user calls
encrypt <- function(msg){
	msgchar <- as.character(msg)
	if( length(msgchar) == 1 ){
		# scalar
		encrypted <- encryptSingle(msgchar)
	} else {
		# vector
		encrypted <- unlist(lapply(msgchar, encryptSingle))
	}
	stopifnot(length(msgchar) == length(encrypted))
	names(encrypted) <- NULL
	return(encrypted)
}

# encrypt car names
cars <- rownames(mtcars)
print(cars)
print(encrypt(cars))