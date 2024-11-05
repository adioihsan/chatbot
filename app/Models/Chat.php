<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

class Chat extends Model
{
    use HasUuids;

    // Fix for uuid PK
    protected $primaryKey = 'id';
    protected $keyType = 'string';
    protected $fillable = [
        'user_id','title', 
    ];

    public function user():BelongsTo
    {
        return $this->belongsTo(User::class,"user_id","id");
    }

    public function History():HasMany
    {
        return $this->hasMany(ChatHistory::class,"chat_id","id");
    }

}