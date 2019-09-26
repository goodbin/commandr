module commandr.utils;

import commandr;
import std.algorithm : find;
import std.typecons : Tuple, Nullable;


// helpers

private Nullable!T wrapIntoNullable(T)(T[] data) pure nothrow @safe @nogc {
    Nullable!T result;
    if (data.length > 0) {
        result = data[0];
    }
    return result;
}

unittest {
    assert(wrapIntoNullable(cast(string[])[]).isNull);

    auto wrapped = wrapIntoNullable(["test"]);
    assert(!wrapped.isNull);
    assert(wrapped.get() == "test");

    wrapped = wrapIntoNullable(["test", "bar"]);
    assert(!wrapped.isNull);
    assert(wrapped.get() == "test");
}

Nullable!Option getOptionByFull(T)(T aggregate, string name) nothrow pure @safe @nogc {
    return aggregate.options.find!(o => o.full == name).wrapIntoNullable;
}

Nullable!Flag getFlagByFull(T)(T aggregate, string name) nothrow pure @safe @nogc {
    return aggregate.flags.find!(o => o.full == name).wrapIntoNullable;
}

Nullable!Option getOptionByShort(T)(T aggregate, string name) nothrow pure @safe @nogc {
    return aggregate.options.find!(o => o.abbrev == name).wrapIntoNullable;
}

Nullable!Flag getFlagByShort(T)(T aggregate, string name) nothrow pure @safe @nogc {
    return aggregate.flags.find!(o => o.abbrev == name).wrapIntoNullable;
}

string getEntryKindName(IEntry entry) nothrow pure @safe {
    if (cast(Option)entry) {
        return "option";
    }

    else if (cast(Flag)entry) {
        return "flag";
    }

    else if (cast(Argument)entry) {
        return "argument";
    }
    else {
        return null;
    }
}